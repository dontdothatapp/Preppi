//
//  SavedView.swift
//  Preppi
//
//  Created by Степан Величко on 21.01.2023.
//

import SwiftUI
import Firebase
import Mixpanel

struct SavedView: View {
    
    @EnvironmentObject var questionModel: QuestionModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.additional_50
                    .ignoresSafeArea(.all)
                
                VStack {
//                    ChipsView()
//
//                    Spacer()
                    
                    ScrollView(.vertical, showsIndicators: false){
                        
                        VStack{
                            
                            if questionModel.savedQuestions.isEmpty {
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
                                    Text("Save the questions to practice them later")
                                        .padding(.top, 1)
                                        .foregroundColor(.text_700)
                                        .font(.system(size: 19, design: .rounded))
                                        .fontWeight(.medium)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 20)
                                    Spacer()
                                } .onAppear {
                                    Mixpanel.mainInstance().track(event: "Saved screen viewed", properties: [
                                        "Type": "Screen",
                                        "Category": "Saved",
                                        "State": 0
                                    ])
                                }
                            } else {
                                //All questions
                                ForEach(questionModel.savedQuestions) { question in
                                    QuestionView(category: question.category, question: question.question, id: question.id, timestamp: question.timestamp)
                                } .onAppear {
                                    Mixpanel.mainInstance().track(event: "Saved screen viewed", properties: [
                                        "Type": "Screen",
                                        "Category": "Saved",
                                        "State": questionModel.savedQuestions.count
                                    ])
                                }
                            }
                        } .padding(.top, 20)
                        
                    }
                    
                    Spacer()
                }
                
            } .navigationTitle("Saved") .onAppear {
                Mixpanel.mainInstance().track(event: "Saved screen viewed", properties: [
                    "Type": "Screen"
                ])
            }
        }
    }
}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView()
    }
}
