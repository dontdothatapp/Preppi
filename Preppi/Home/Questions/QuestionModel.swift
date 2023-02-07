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
            .getDocuments { (querySnapshot, error) in
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
    
    func getUnsavedQuestions(completion: @escaping ([Question]) -> Void) {
        getSavedQuestions { savedQuestions in
            let unsavedQuestions = self.questionList.filter { !savedQuestions.contains($0) }
            completion(unsavedQuestions)
        }
    }

    func getSavedQuestionsByCategory(category: String, completion: @escaping ([Question]) -> Void) {
        getSavedQuestions { savedQuestions in
            let savedQuestionsByCategory = savedQuestions.filter { $0.category == category }
            completion(savedQuestionsByCategory)
        }
    }
    
}
