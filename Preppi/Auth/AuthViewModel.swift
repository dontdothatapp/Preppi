//
//  AuthViewModel.swift
//  Preppi
//
//  Created by Степан Величко on 25.01.2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    private let service = UserService()
    @Published var currentUser: User?
    @Published var hasError = false
    @Published var errorMessage = ""
//    @Published var showResetScreen = false
//    @Published var showResetAlert = false
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
        //print("DEBUG: User session is: \(String(describing: self.userSession?.uid))")
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print("DEBUG: Auth error.localized description: \(error!.localizedDescription)")
                self.hasError = true
                self.errorMessage = error!.localizedDescription
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            print("DEBUG: Login successful")
            self.fetchUser()
        }
    }
    
    func resetPassword(withEmail email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                print("DEBUG: Auth error.localized description: \(error!.localizedDescription)")
                self.hasError = true
                self.errorMessage = error!.localizedDescription
                return
            }
            
            self.showResetAlert = true
            //self.showResetScreen = false
        }
    }
    
    func register(withEmail email: String, password: String, name: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print("DEBUG: Registration error: \(error!.localizedDescription)")
                self.hasError = true
                self.errorMessage = error!.localizedDescription
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
            self.fetchUser()
            
        }
    }
    
    func signOut() {
        userSession = nil
        currentUser = nil
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
