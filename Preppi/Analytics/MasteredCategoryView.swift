//
//  MasteredCategoryView.swift
//  Preppi
//
//  Created by Степан Величко on 15.02.2023.
//

import SwiftUI

struct MasteredCategoryView: View {
    
    @StateObject var questionModel = QuestionModel()
    @State var masteredQuestions = [Question]()
    @State var filteredMasteredQuestions = [Question]()
    @State var selectedCategory: String
    
    var body: some View {
        ZStack {
            
            Color.additional_50
                .ignoresSafeArea(.all)
            
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    
                    if filteredMasteredQuestions.isEmpty {
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
                        ForEach(filteredMasteredQuestions) {item in
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
    
    /*
     Current state
     When you open a catergory screen, it always show you the empty state sceeen
     But if you'll open another tab and then open the category screen again: now it shows you the actual items, instead of empty screen
     */
    
    func getMasteredQuestionsArray() {
        questionModel.getMasteredQuestionsArray { (masteredItem) in
            self.masteredQuestions = masteredItem
        }
        for item in self.masteredQuestions {
            if item.category == selectedCategory {
                filteredMasteredQuestions.append(item)
                print("DEBUG: filteredMasteredQuestions count: \(filteredMasteredQuestions.count)")
            } else { }
        }
        print("DEBUG: getMasteredQuestionsArray: \(masteredQuestions)")
    }
    
}

//struct MasteredCategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        MasteredCategoryView(selectedCategory: "product design").onAppear(perform: {
//            MasteredCategoryView(selectedCategory: "product design").getMasteredQuestionsArray()
//        })
//    }
//}

struct MasteredCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        let questions = [
            Question(id: "1", category: "product design", question: "What is the question here?", type: "product", timestamp: Date())
        ]
        return MasteredCategoryView(filteredMasteredQuestions: questions, selectedCategory: "product design")
    }
}
