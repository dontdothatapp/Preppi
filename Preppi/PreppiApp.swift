//
//  PreppiApp.swift
//  Preppi
//
//  Created by Степан Величко on 16.01.2023.
//

import SwiftUI
import Firebase
import Mixpanel

@main
struct PreppiApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    @ObservedObject var questionModel = QuestionModel()
    @ObservedObject var questionManager = QuestionManager()
    let mixpanel = Mixpanel.initialize(token: Config.mixpanelProjectToken, trackAutomaticEvents: true)
    
    init() {
        FirebaseApp.configure()
        questionModel.getData()
        questionModel.newLoadMasteredQuestions()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(questionModel)
                .environmentObject(questionManager)
        }
    }
}
