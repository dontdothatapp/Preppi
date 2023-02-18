//
//  TempQuestionView.swift
//  Preppi
//
//  Created by Степан Величко on 31.01.2023.
//

import SwiftUI
import Firebase

struct TempQuestionView: View {
    
    @ObservedObject var questionModel = QuestionModel()
    
    var body: some View {
        List(questionModel.questionList) { item in
            Text(item.category)
                .font(.caption)
            Text(item.question)
        }
        
    }
    
    init() {
        questionModel.getData()
    }
}

struct TempQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        TempQuestionView()
    }
}
