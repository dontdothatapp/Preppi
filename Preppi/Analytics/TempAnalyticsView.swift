//
//  TempAnalyticsView.swift
//  Preppi
//
//  Created by Степан Величко on 11.02.2023.
//

import SwiftUI

struct TempAnalyticsView: View {
    
    @State var currentProgress: Int = 1
    @State var category: String = ""
    @ObservedObject var questionModel = QuestionModel()
    @State var statsForMasteredQuestions = [Stats]()
    @State var masteredQuestions = [Question]()
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack{
                
                ForEach(statsForMasteredQuestions) { item in
                    ProgressCircleView(category: item.category, mastered: item.mastered, total: item.total)
                }
                
                
                Text("Mastered data")
                    .font(.title2)
                ForEach(statsForMasteredQuestions) { category in
                    TempStatBlockView(category: category.category, total: category.total, mastered: category.mastered)
                }
                
            } .onAppear(perform: getMasteredQuestionsArray)
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

struct TempAnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        TempAnalyticsView()
    }
}
