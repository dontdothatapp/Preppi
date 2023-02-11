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
        NavigationView {
            ScrollView {
                VStack{
                    
//                    Text("Mastered questions")
//                        .font(.title2)
//                    ForEach(masteredQuestions) { question in
//                        QuestionView(category: question.category, question: question.question)
//                    }
                    
                    ForEach(statsForMasteredQuestions) { category in
                        TempStatBlockView(category: category.category, total: category.total, mastered: category.mastered)
                    }
                    
                }
                .onAppear(perform: getMasteredQuestionsArray)
                //.onAppear(perform: fetchMasteredQuestions)
            } .navigationTitle("Mastered items")
        }
    }
    
    init() {
        questionModel.getData()
    }
    
    func getMasteredQuestionsArray() {
        questionModel.getMasteredQuestionsArray { (masteredQuestions) in
            self.masteredQuestions = masteredQuestions
            print("DEBUG: forming array \(masteredQuestions.count)")
            fetchMasteredQuestions()
        }
    }
    
    func fetchMasteredQuestions() {
        questionModel.getStatsObjects(masteredQuestions: masteredQuestions) { (masteredQQuestions) in
            print("DEBUG: masteredArray: \(masteredQuestions.count)")
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
