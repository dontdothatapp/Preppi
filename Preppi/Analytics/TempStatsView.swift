//
//  TempStatsView.swift
//  Preppi
//
//  Created by Степан Величко on 08.02.2023.
//

import SwiftUI
import Firebase

struct TempStatsView: View {
    @ObservedObject var questionModel = QuestionModel()
    @State var statsForMasteredQuestions = [Stats]()
    @State var masteredQuestions = [Question]()
    
    var body: some View {
        ScrollView {
            VStack{
                
                Text("Mastered questions")
                    .font(.title2)
                ForEach(masteredQuestions) { question in
                    QuestionView(category: question.category, question: question.question)
                }
                
                Text("List of mastered items")
                    .font(.title2)
                    .padding(.top, 40)
                
                ForEach(statsForMasteredQuestions) { category in
                    TempStatBlockView(category: category.category, total: category.total, mastered: category.mastered)
                }
                
            }
            .onAppear(perform: getMasteredQuestionsArray)
        }
            //.onAppear(perform: fetchMasteredQuestions)
    }
    
    init() {
        questionModel.getData()
    }
    
    func getMasteredQuestionsArray() {
        questionModel.getMasteredQuestionsArray { (masteredQuestions) in
            self.masteredQuestions = masteredQuestions
            print("DEBUG: Mastered questions from third func: \(self.masteredQuestions)")
        }
    }
    
    func fetchMasteredQuestions() {
        questionModel.getStatsObjects(masteredQuestions: masteredQuestions) { (masteredQQuestions) in
            self.statsForMasteredQuestions = masteredQQuestions
            //print("DEBUG: Mastered array from func: \(self.statsForMasteredQuestions)")
        }
    }
    
}



struct TempStatsView_Previews: PreviewProvider {
    static var previews: some View {
        TempStatsView().onAppear (perform: {
            TempStatsView().fetchMasteredQuestions()
        })
    }
}
