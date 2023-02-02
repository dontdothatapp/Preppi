//
//  QuestionModel.swift
//  Preppi
//
//  Created by Степан Величко on 31.01.2023.
//

import Foundation
import Firebase
import FirebaseFirestore

class QuestionModel: ObservableObject {
    
    @Published var questionList = [Question]()
    
    func getData() {
        
        //Get a reference to the database
        let db = Firestore.firestore()
        
        //Read the documents from a specific path
        db.collection("questions_product").getDocuments { snapshot, error in
            
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
                                            question: d["question"] as? String ?? "")
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
    
//    func getUniqueCategories(b: Any) {
//
//        let b = questionList.self
//        let a = Array(Set(b.map {_ in Categories(id: b.category)}))
//
//
//        //var uniquechips = Array(Set(QuestionModel().questionList.map {Categories(id: $0.category)}))
//
//        return a
//    }
}
