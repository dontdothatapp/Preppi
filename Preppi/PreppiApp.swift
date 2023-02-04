//
//  PreppiApp.swift
//  Preppi
//
//  Created by Степан Величко on 16.01.2023.
//

import SwiftUI
import Firebase

@main
struct PreppiApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    @ObservedObject var questionModel = QuestionModel()
    
    init() {
        FirebaseApp.configure()
        questionModel.getData()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
