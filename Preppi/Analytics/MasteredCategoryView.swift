//
//  MasteredCategoryView.swift
//  Preppi
//
//  Created by Степан Величко on 15.02.2023.
//

import SwiftUI
import Mixpanel

struct MasteredCategoryView: View {
    
    @State var selectedCategory: String
    @State var tempHaveSomeItems = false
    @EnvironmentObject var questionModel: QuestionModel
    
    var body: some View {
        ZStack {
            
            Color.additional_50
                .ignoresSafeArea(.all)
            
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    
//                    if tempHaveSomeItems == false {
//                        VStack{
//                            Spacer()
//                            Image("empty_state")
//                                .resizable()
//                                .scaledToFit()
//                                .ignoresSafeArea(.all, edges: .top)
//                                .padding(.horizontal, 30)
//                            Text("Oh damn, it's empty here")
//                                .foregroundColor(.text_900)
//                                .font(.system(size: 28, design: .rounded))
//                                .fontWeight(.medium)
//                                .multilineTextAlignment(.center)
//                                .padding(.horizontal, 20)
//                            Text("You'll see here all mastered questions")
//                                .padding(.top, 1)
//                                .foregroundColor(.text_700)
//                                .font(.system(size: 19, design: .rounded))
//                                .fontWeight(.medium)
//                                .multilineTextAlignment(.center)
//                                .padding(.horizontal, 20)
//                            Spacer()
//                        }
//                    } else {
                    
                    /*
                     SO
                     The current problem is that questionManager receive an array from Firebase only once, but then
                     when I directly remove/add items from the Firebase –> I didn't get any updates
                     
                     The category counter works because the StatsObjects are still counted in QuestionModel class
                     */
                    
                    ForEach(questionModel.masteredQuestions) {item in
                        if item.category == selectedCategory {
                            QuestionForAnalyticsView(question: item.question, id: item.id)
                        }
                    }
                } .padding(.top, 20)
                
                Spacer()
            }
        } .navigationTitle(selectedCategory) .onAppear {
            Mixpanel.mainInstance().track(event: "Mastered category screen viewed", properties: [
                "Type": "Screen"
            ])
        }
    }
}

//struct MasteredCategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        MasteredCategoryView(selectedCategory: "product strategy")
//            .environmentObject(QuestionModel())
//    }
//}

//struct MasteredCategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        let questions = [
//            Question(id: "1", category: "product design", question: "What is the question here?", type: "product", timestamp: Date())
//        ]
//        return MasteredCategoryView(filteredMasteredQuestions: questions, selectedCategory: "product design")
//    }
//}
