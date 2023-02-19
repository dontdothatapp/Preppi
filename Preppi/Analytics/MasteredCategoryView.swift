//
//  MasteredCategoryView.swift
//  Preppi
//
//  Created by Степан Величко on 15.02.2023.
//

import SwiftUI

struct MasteredCategoryView: View {
    
    @ObservedObject var questionModel = QuestionModel()
    @State var masteredQuestions = [Question]()
    @State var selectedCategory: String
    
    var body: some View {
        ZStack {
            
            Color.additional_50
                .ignoresSafeArea(.all)
            
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    
                    if masteredQuestions.count < 1 {
                        VStack{
                            Spacer()
                            Image("empty_state")
                                .resizable()
                                .scaledToFit()
                                .ignoresSafeArea(.all, edges: .top)
                                .padding(.horizontal, 30)
                            Text("Oh damn, it's empty here")
                                .foregroundColor(.text_900)
                                .font(.system(size: 28, design: .rounded))
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                            Text("You'll see here all mastered questions")
                                .padding(.top, 1)
                                .foregroundColor(.text_700)
                                .font(.system(size: 19, design: .rounded))
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                            Spacer()
                        }
                    } else {
                        
//                        ForEach(filteredArray) { item in
//                            QuestionForAnalyticsView(question: item.question, id: item.id)
//                        }
                        
                        ForEach(masteredQuestions) {item in
                            if item.category == selectedCategory {
                                QuestionForAnalyticsView(question: item.question, id: item.id)
                            }
                        }
                    }
                } .padding(.top, 20)
                
                Spacer()
            } .onAppear(perform: getMasteredQuestionsArray)
            
        } .navigationTitle(selectedCategory)
    }
    
    func getMasteredQuestionsArray() {
        questionModel.getMasteredQuestionsArray { (masteredQuestions) in
            self.masteredQuestions = masteredQuestions
        }
        print("DEBUG: getMasteredQuestionsArray: \(masteredQuestions)")
    }
    
}

struct MasteredCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        MasteredCategoryView(selectedCategory: "product design").onAppear(perform: {
            MasteredCategoryView(selectedCategory: "product design").getMasteredQuestionsArray()
        })
    }
}
