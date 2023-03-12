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
    @Published var savedQuestions = [Question]()
    @Published var masteredQuestions = [Question]()
    @Published var statsForMasteredQuestions = [Stats]()
    @Published var filteredMasteredQuestions = [Question]()
    
    
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
    
    
    //Saved questions functions
    
    func loadSavedQuestions() {
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
                
                //var questions = [Question]()
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
                            if self.savedQuestions.contains(where: {$0.id == questionObject.id}) {
                                //item exist –> do nothing
                            } else {
                                self.savedQuestions.append(questionObject)
                            }
                        })
                }
                
                for change in querySnapshot!.documentChanges {
                    switch change.type {
                    case .added:
                        _ = "Test value"
                    case .modified:
                        _ = Question(id: change.document.documentID,
                                                category: change.document.data()["category"] as? String ?? "",
                                                question: change.document.data()["question"] as? String ?? "",
                                                type: change.document.data()["type"] as? String ?? "",
                                                timestamp: change.document.data()["timestamp"] as? Date ?? Date())
                    case .removed:
                        let id = change.document.documentID
                        self.savedQuestions.removeAll { $0.id == id}
                    }
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
    
    func newCheckSavedQuestion(questionID: String) -> Bool {
        guard let user = Auth.auth().currentUser else {
            //handle error
            return false
        }

        let db = Firestore.firestore()
        var isItSaved = false

        db.collection("users").document(user.uid)
            .collection("saved_questions")
            .addSnapshotListener{ (querySnapshot, error) in
                if let error = error {
                    print("DEBUG: Error: \(error.localizedDescription)")
                    return
                }

                for document in querySnapshot!.documents {
                    let savedID = document.data()["question_id"] as! String
                    if questionID == savedID {
                        isItSaved = true
                    } else {
                        isItSaved = false
                    }
                }
            }
        return isItSaved
    }
    
    //Mastered questions functions
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
    
    func loadMasteredQuestions() {
        guard let user = Auth.auth().currentUser else {
            //handle error
            return
        }
        
        let db = Firestore.firestore()
        
        //get access to mastered_questions collection inside users
        db.collection("users").document(user.uid)
            .collection("mastered_questions").order(by: "timestamp", descending: false)
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    //handle error
                    print("DEBUG: Error: \(error.localizedDescription)")
                }
                
                //Pick each element in mastered_questions colletction and append them to masteredQuestions array
                for document in querySnapshot!.documents {
                    
                    let questionId = document.data()["question_id"] as! String
                    //Go to collection questions and take a question with question_id from users->mastered_questions–>question_id
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
                            if self.masteredQuestions.contains(where: {$0.id == masteredQuestionObject.id}) {
                                // item exists
                            } else {
                                //item could not be found
                                self.masteredQuestions.append(masteredQuestionObject)
                            }
                        })
                }
                
                for change in querySnapshot!.documentChanges {
                    switch change.type {
                    case .removed:
                        let id = change.document.documentID
                        self.masteredQuestions.removeAll { $0.id == id}
                    case .added:
                        _ = "Test Value"
                    case .modified:
                        _ = Question(id: change.document.documentID,
                                                category: change.document.data()["category"] as? String ?? "",
                                                question: change.document.data()["question"] as? String ?? "",
                                                type: change.document.data()["type"] as? String ?? "",
                                                timestamp: change.document.data()["timestamp"] as? Date ?? Date())
                    }
                    
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
    
    func fetchMasteredQuestions() {
        self.getStatsObjects(masteredQuestions: self.masteredQuestions) { (masteredQQuestions) in
            self.statsForMasteredQuestions = masteredQQuestions
            //print("DEBUG: Mastered array from func: \(self.statsForMasteredQuestions)")
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
