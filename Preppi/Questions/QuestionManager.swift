//
//  QuestionManager.swift
//  Preppi
//
//  Created by Степан Величко on 09.03.2023.
//

import Foundation

class QuestionManager: ObservableObject {
    @Published var allQuestions: [Question] = []
    @Published var masteredQuestions: [Question] = []
    private let questionModel = QuestionModel()
    
//    func getMasteredQuestions() {
//        //print("DE: func getMasteredQuestions started")
//        
//        questionModel.loadMasteredQuestions { masteredQQuestions in
//            DispatchQueue.main.async {
//                self.masteredQuestions = masteredQQuestions
//                //print("DE: loop started. Array: \(self.masteredQuestions)")
//            }
//        }
//    }
    
}
