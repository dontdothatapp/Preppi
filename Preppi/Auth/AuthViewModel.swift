//
//  AuthViewModel.swift
//  Preppi
//
//  Created by Степан Величко on 25.01.2023.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    private let service = UserService()
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
        //print("DEBUG: User session is: \(String(describing: self.userSession?.uid))")
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print("DEBUG: Registration error: \(error!.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            print("DEBUG: Login successful")
        }
    }
    
    func register(withEmail email: String, password: String, name: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print("DEBUG: Registration error: \(error!.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            print("DEBUG: Reg successful")
            
            let data = ["email": email,
                        "name": name,
                        "uid": user.uid]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    print("DEBUG: Did upload user data")
                }
            
        }
    }
    
    func signOut() {
        userSession = nil
        try? Auth.auth().signOut()
        print("DEBUG: User session: \(String(describing: self.userSession))")
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return}
        
        service.fetchUser(withUid: uid) { user in
            self.currentUser = user
        }
    }
    
}
