//
//  UserModel.swift
//  Preppi
//
//  Created by Степан Величко on 30.01.2023.
//

import Foundation
import Firebase

class UserModel: ObservableObject {
    @Published var user = [UserStruct]()
    
    
    func getData() {
        
        //Get reference to the database
        let db = Firestore.firestore()
        
        //Read the documents
        db.collection("users").getDocuments { snapshot, error in
            if error == nil {
                //no errors
                if let snapshot = snapshot {
                    
                    //Update the user property in the main thread
                    DispatchQueue.main.async {
                        
                        //Get all documents and fill the UserStructs
                        self.user = snapshot.documents.map { d in
                            
                            //Create a UserStruct item for each document returned
                            return UserStruct(id: d["uid"] as? String ?? "",
                                              name: d["name"] as? String ?? "",
                                              email: d["email"] as? String ?? "")
                            
                        }
                    }
                }
                
            } else {
                //handle errors
            }
        }
        
    }
    
    func fetchUser() {
        
    }
}
