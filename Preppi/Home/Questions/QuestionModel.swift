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
        db.collection("questions").getDocuments { snapshot, error in
            
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
                                            type: d["type"] as? String ?? "")
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
            .collection("saved_questions")
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
                                                          type: question["type"] as? String ?? "")
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
        db.collection("users").document(userId).collection("saved_questions").document(questionId).setData([
            "question_id": questionId
            
        ]) { (error) in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Question successfully saved!")
            }
        }
    }
    
    func deleteSavedQuestion(questionId: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        db.collection("users").document(userId).collection("saved_questions").document(questionId).delete { (error) in
            if let error = error {
                print("Error deleting document: \(error)")
            } else {
                print("Question successfully deleted!")
            }
        }
    }

    
    func masterQuestion(questionId: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        db.collection("users").document(userId).collection("mastered_questions").document(questionId).setData([
            "question_id": questionId
            
        ]) { (error) in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Question successfully mastered!")
            }
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
            .getDocuments { (querySnapshot, error) in
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
                                                                   type: masteredQuestion["type"] as? String ?? "")
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
        completion(statsList)
        
    }
    
    func getUnsavedQuestions(completion: @escaping ([Question]) -> Void) {
        getSavedQuestions { savedQuestions in
            let unsavedQuestions = self.questionList.filter { !savedQuestions.contains($0) }
            completion(unsavedQuestions)
        }
    }
    
    func getSavedQuestionsByCategory(completion: @escaping ([Question]) -> Void) {
        getSavedQuestions { savedQuestions in
            let savedQuestionsByCategory = savedQuestions.filter { $0.category == self.selectedCategory }
            completion(savedQuestionsByCategory)
        }
    }
    
}
