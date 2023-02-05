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
    
    
    
}
