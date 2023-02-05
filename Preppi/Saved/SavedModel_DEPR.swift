//
//  SavedModel.swift
//  Preppi
//
//  Created by Степан Величко on 05.02.2023.
//

//import Foundation
//import FirebaseAuth
//import FirebaseFirestore
//import FirebaseFirestoreSwift

//func getSavedQuestions(completion: @escaping ([Question]) -> Void) {
//    guard let user = Auth.auth().currentUser else {
//        // handle error: no user is logged in
//        return
//    }
//
//    let db = Firestore.firestore()
//    db.collection("users").document(user.uid)
//        .collection("saved_questions")
//        .getDocuments { (querySnapshot, error) in
//            if let error = error {
//                // handle error
//                print("DEBUG: Error \(error.localizedDescription)")
//                return
//            }
//
//            var questions = [Question]()
//            for document in querySnapshot!.documents {
//                let questionId = document.data()["question_id"] as! String
//                db.collection("questions").document(questionId)
//                    .getDocument(completion: { (questionSnapshot, error) in
//                        if let error = error {
//                            // handle error
//                            print("DEBUG: Error \(error.localizedDescription)")
//                            return
//                        }
//
//                        let question = questionSnapshot!.data()!
//                        let questionObject = Question(id: questionSnapshot!.documentID,
//                                                      category: question["category"] as? String ?? "",
//                                                      question: question["question"] as? String ?? "",
//                                                      type: question["type"] as? String ?? "")
//                        questions.append(questionObject)
//
//                        if questions.count == querySnapshot!.documents.count {
//                            completion(questions)
//                        }
//                    })
//            }
//        }
//}
//
//func saveQuestion(questionId: String) {
//    guard let userId = Auth.auth().currentUser?.uid else { return }
//    let db = Firestore.firestore()
//    db.collection("users").document(userId).collection("saved_questions").document(questionId).setData([
//        "question_id": questionId
//
//    ]) { (error) in
//        if let error = error {
//            print("Error writing document: \(error)")
//        } else {
//            print("Question successfully saved!")
//        }
//    }
//}

