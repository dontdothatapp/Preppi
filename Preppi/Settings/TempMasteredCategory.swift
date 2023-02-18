//
//  TempMasteredCategory.swift
//  Preppi
//
//  Created by Степан Величко on 18.02.2023.
//

import SwiftUI

struct TempMasteredCategory: View {
    
    @ObservedObject var questionModel = QuestionModel()
    @State var masteredQuestions = [Question]()
    @State var selectedCategory: String
    
    var body: some View {
        ZStack {
            
            Color.additional_50
                .ignoresSafeArea(.all)
            
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    
                    ForEach(masteredQuestions) {item in
                        if item.category == selectedCategory {
                            QuestionForAnalyticsView(question: item.question, id: item.id)
                        }
                    }
                }
                
                Spacer()
            }
            
        } .onAppear(perform: getMasteredQuestionsArray)
    }
    
    func getMasteredQuestionsArray() {
        questionModel.getMasteredQuestionsArray { (masteredQuestions) in
            self.masteredQuestions = masteredQuestions
        }
    }
    
}

struct TempMasteredCategory_Previews: PreviewProvider {
    static var previews: some View {
        TempMasteredCategory(selectedCategory: "product design")
    }
}
