//
//  TempEnvironment.swift
//  Preppi
//
//  Created by Степан Величко on 12.03.2023.
//

import SwiftUI

struct TempEnvironment: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var masteredModel: QuestionModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack{
                Text("New way")
                    .font(.title)
                    .padding(.bottom, 20)
                ForEach (masteredModel.masteredQuestions) {item in
                    QuestionForAnalyticsView(question: item.question, id: item.id)
                }
                Button("Master random question") {
                    masteredModel.masterQuestion(questionId: masteredModel.questionList.randomElement()!.id)
                    //questionList.randomElement()
                }
            } .onAppear {
                print("DEBUG: MasteredQuestions: \(masteredModel.masteredQuestions)")
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
