//
//  HomeView.swift
//  Preppi
//
//  Created by Степан Величко on 21.01.2023.
//

import SwiftUI
import Mixpanel

struct HomeView: View {
    
    let questionList: [Question]
    @State private var currentQuestion: Question?
    @EnvironmentObject var questionModel: QuestionModel
    var saveQuestion: (Question) -> () = { _ in }
    @State var IsSaved: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                //Menu button
                HStack {
                    Spacer()
                    
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .padding(.trailing, 27)
                            .foregroundColor(Color.text_900)
                    }
                }.padding(.top, 60).padding(.bottom, 10)
                
                if currentQuestion == nil {
                    CardView(firstCard: true, question: Question(id: "asd", category: "Ready to start?", question: "Tap on the button below to get the first question👇", type: "product", timestamp: Date()))
                } else {
                    CardView(firstCard: false, question: currentQuestion!)
//                    CardView(firstCard: false, question: currentQuestion ?? questionModel.questionList.randomElement()!)
                }
                
                Spacer()
                
                Button(action: {
                    self.currentQuestion = questionModel.questionList.randomElement()
                    Mixpanel.mainInstance().track(event: "New question button", properties: [
                        "Type": "Button",
                        "Category": "Home",
                        "Screen": "Home"
                    ])
                }) {
                    HStack {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .foregroundColor(.primary_900)
                        Text("New question")
                    }
                    .foregroundColor(Color.text_900)
                    .frame(width: 350, height: 50)
                    .background(
                        Color.additional_50
                            .cornerRadius(16)
                            .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 4)
                    )
                }
                
                Spacer()
                
            }
            .background(Color.additional_50) .onAppear {
                Mixpanel.mainInstance().track(event: "Home screen viewed", properties: [
                    "Type": "Screen",
                    "Category": "Home"
                ])
            } 
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(questionList: [Question(id: "2", category: "Cate", question: "que", type: "product", timestamp: Date()),
                                Question(id: "55", category: "CAte2", question: "que2", type: "product", timestamp: Date())])
    }
}
