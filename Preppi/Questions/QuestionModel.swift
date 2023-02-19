//
//  QuestionModel.swift
//  Preppi
//
//  Created by Степан Величко on 31.01.2023.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class QuestionModel: ObservableObject {
    
    @Published var questionList = [Question]()
    @Published var selectedCategory: String = ""
    @Published var savedByCategory = [Question]()
    
    func getData() {
        
        //Get a reference to the database
        let db = Firestore.firestore()
        
        //Read the documents from a specific path
        db.collection("questions")
            .addSnapshotListener { snapshot, error in
            
            //Check the errors
            if error == nil {
                //no errors
                
                if let snapshot = snapshot {
                    
                    //Update the questionList property in the main thread
                    DispatchQueue.main.async {
                        
                        //Get all the documents and create Question struct
                        self.questionList = snapshot.documents.map { d in
                            
                            //Create a Quaetion item for each document returned
                            return Question(id: d.documentID,
                                            category: d["category"] as? String ?? "",
                                            question: d["question"] as? String ?? "",
                                            type: d["type"] as? String ?? "",
                                            timestamp: d["timestamp"] as? Date ?? Date())
                        }
                    }
                }
                
            } else { return }
        }
        
    }
    
    func getUniqueCategories() -> [String] {
        let uniqueCategories = Set(questionList.map { $0.category })
        return Array(uniqueCategories)
    }
    
    //Not sure if it works, can't find a way how to call it on the HomeScreen
    func getRandomQuestion() -> Question? {
        guard !questionList.isEmpty else { return nil }
        return questionList.randomElement()
    }
    
    func getSavedQuestions(completion: @escaping ([Question]) -> Void) {
        guard let user = Auth.auth().currentUser else {
            // handle error: no user is logged in
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(user.uid)
            .collection("saved_questions").order(by: "timestamp", descending: false)
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    // handle error
                    print("DEBUG: Error \(error.localizedDescription)")
                    return
                }
                
                var questions = [Question]()
                for document in querySnapshot!.documents {
                    let questionId = document.data()["question_id"] as! String
                    db.collection("questions").document(questionId)
                        .getDocument(completion: { (questionSnapshot, error) in
                            if let error = error {
                                // handle error
                                print("DEBUG: Error \(error.localizedDescription)")
                                return
                            }
                            
                            let question = questionSnapshot!.data()!
                            let questionObject = Question(id: questionSnapshot!.documentID,
                                                          category: question["category"] as? String ?? "",
                                                          question: question["question"] as? String ?? "",
                                                          type: question["type"] as? String ?? "",
                                                          timestamp: question["timestamp"] as? Date ?? Date())
                            questions.append(questionObject)
                            
                            if questions.count == querySnapshot!.documents.count {
                                completion(questions)
                            }
                        })
                }
            }
    }

    
    func saveQuestion(questionId: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        let timestamp = Timestamp(date: Date())
        db.collection("users").document(userId).collection("saved_questions").document(questionId).setData([
            "question_id": questionId,
            "timestamp": timestamp
            
        ]) { (error) in
            if let error = error {
                print("Error writing document: \(error)")
            } else { }
        }
    }
    
    func deleteSavedQuestion(questionId: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        db.collection("users").document(userId).collection("saved_questions").document(questionId).delete { (error) in
            if let error = error {
                print("Error deleting document: \(error)")
            } else { }
        }
    }

    
    func masterQuestion(questionId: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        let timestamp = Timestamp(date: Date())
        db.collection("users").document(userId).collection("mastered_questions").document(questionId).setData([
            "question_id": questionId,
            "timestamp": timestamp
            
        ]) { (error) in
            if let error = error {
                print("Error writing document: \(error)")
            } else { }
        }
    }
    
    func deleteMasteredQuestion(questionId: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        db.collection("users").document(userId).collection("mastered_questions").document(questionId).delete { (error) in
            if let error = error {
                print("Error deleting from mastered: \(error)")
            } else { }
        }
    }
    
    func getMasteredQuestionsArray(completion: @escaping ([Question]) -> Void) {
        guard let user = Auth.auth().currentUser else {
            //handle error
            return
        }
        //Array of mastererd questions
        var masteredQuestions = [Question]()
        
        let db = Firestore.firestore()
        
        //get access to mastered_questions collection inside users
        db.collection("users").document(user.uid)
            .collection("mastered_questions")
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    //handle error
                    print("DEBUG: Error: \(error.localizedDescription)")
                }
                
                //Pick each element in mastered_questions colletction and append them to masteredQuestions array
                for document in querySnapshot!.documents {
                    
                    let questionId = document.data()["question_id"] as! String
                    //Go to collection questions and take a question with question_if from users->mastered_questions–>question_id
                    db.collection("questions").document(questionId)
                        .getDocument(completion: { (questionSnapshot, error) in
                            if let error = error {
                                //handle error
                                print("DEBUG: Error: \(error.localizedDescription)")
                                return
                            }
                            
                            let masteredQuestion = questionSnapshot!.data()!
                            let masteredQuestionObject = Question (id: questionSnapshot!.documentID,
                                                                   category: masteredQuestion["category"] as? String ?? "",
                                                                   question: masteredQuestion["question"] as? String ?? "",
                                                                   type: masteredQuestion["type"] as? String ?? "",
                                                                   timestamp: masteredQuestion["timestamp"] as? Date ?? Date())
                            masteredQuestions.append(masteredQuestionObject)
                            
                            if masteredQuestions.count == querySnapshot!.documents.count {
                                completion(masteredQuestions)
                            }
                        })
                }
            }
    }
    
    func getStatsObjects(masteredQuestions: [Question], completion: @escaping ([Stats]) -> Void) {
        let uniqueCategories = Set(questionList.map { $0.category })
        var statsList = [Stats]()
        
        for category in uniqueCategories {
            //print("DEBUG: Current mastered: \(masteredQuestions.count)")
            
            //print("DEBUG: Selected category: \(category)")
            //total questions in category
            let total = questionList.filter({ $0.category == category }).count
            let mastered = masteredQuestions.filter({ $0.category == category}).count
            //print("DEBUG: Mastered questions in \(category): \(mastered)")
            let stats = Stats(id: UUID().uuidString, category: category, mastered: mastered, total: total)
            //print("DEBUG: StatsObject: \(stats)")
            statsList.append(stats)
        }
        completion(statsList.sorted { $0.category < $1.category})
    }
    
    func getSavedQuestionsByCategory(completion: @escaping ([Question]) -> Void) {
        getSavedQuestions { savedQuestions in
            let savedQuestionsByCategory = savedQuestions.filter { $0.category == self.selectedCategory }
            completion(savedQuestionsByCategory)
        }
    }
    
    func checkSavedQuestion(questionID: String, completion: @escaping (Bool) -> Void) {
        guard let user = Auth.auth().currentUser else {
            //handle error
            completion(false)
            return
        }

        let db = Firestore.firestore()

        db.collection("users").document(user.uid)
            .collection("saved_questions")
            .addSnapshotListener{ (querySnapshot, error) in
                if let error = error {
                    print("DEBUG: Error: \(error.localizedDescription)")
                    completion(false)
                    return
                }

                for document in querySnapshot!.documents {
                    let savedID = document.data()["question_id"] as! String
                    if questionID == savedID {
                        completion(true)
                        return
                    } else { }
                }
                completion(false)
            }
    }
    
    func checkMasteredQuestion(questionID: String, completion: @escaping (Bool) -> Void) {
        guard let user = Auth.auth().currentUser else {
            //handle error
            completion(false)
            return
        }

        let db = Firestore.firestore()

        db.collection("users").document(user.uid)
            .collection("mastered_questions")
            .addSnapshotListener{ (querySnapshot, error) in
                if let error = error {
                    print("DEBUG: Error: \(error.localizedDescription)")
                    completion(false)
                    return
                }

                for document in querySnapshot!.documents {
                    let masteredID = document.data()["question_id"] as! String
                    if questionID == masteredID {
                        completion(true)
                        return
                    } else {
                        
                    }
                }
                completion(false)
            }
    }
    
}
