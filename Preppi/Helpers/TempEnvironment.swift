//
//  TempEnvironment.swift
//  Preppi
//
//  Created by Степан Величко on 12.03.2023.
//

import SwiftUI

struct TempEnvironment: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var questionModel: QuestionModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack{
                Text("Saved: New way")
                    .font(.title)
                    .padding(.bottom, 20)
                ForEach (questionModel.savedQuestions) {item in
                    QuestionView(category: item.category, question: item.question, id: item.id, timestamp: item.timestamp)
                }
//                Button("Master random question") {
//                    questionModel.masterQuestion(questionId: questionModel.questionList.randomElement()!.id)
//                    //questionList.randomElement()
//                }
            }
        }
    }
}

struct TempEnvironment_Previews: PreviewProvider {
    static var previews: some View {
        TempEnvironment()
            .environmentObject(AuthViewModel())
            .environmentObject(QuestionModel())
    }
}
