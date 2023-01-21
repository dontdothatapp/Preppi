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
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
