//
//  HomeView.swift
//  Preppi
//
//  Created by Степан Величко on 21.01.2023.
//

import SwiftUI

struct HomeView: View {
    
    let questionList: [Question]
    @State private var currentQuestion: Question?
    @ObservedObject var questionModel = QuestionModel()
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
                
                //This code checks if currentQuestion is not nil, which is an optional Question value. If it's not nil, it passes question as an argument to the CardView initializer. The code unwraps the optional value of currentQuestion by using if let syntax, which is a type of optional binding. The purpose of this code is to only display the CardView if currentQuestion has a value, avoiding a runtime error.
                if let question = currentQuestion {
                    CardView(firstCard: false, isSaved: IsSaved, question: question)
                } else {
                    
                    //Temp solution. Should find a way how to show the random question when the app starts
                    CardView(firstCard: true, isSaved: false, question: Question(id: "asd", category: "Ready to start?", question: "Tap on the button below to get the first question👇", type: "product", timestamp: Date()))
                }
                
                Spacer()
                
                //New Question button. This code checks if the questionList array is not empty, meaning it has at least one element. If questionList is not empty, the code assigns a randomly selected element of questionList to currentQuestion. The .randomElement() method is called on questionList, which returns an optional value of the random element. If questionList is empty, currentQuestion will not be assigned a value.
                Button(action: {
                    if !questionList.isEmpty {
                        self.currentQuestion = questionList.randomElement()
                        questionModel.checkSavedQuestion(questionID: currentQuestion!.id) { isSavedModel in
                            IsSaved = isSavedModel
                            print("DEBUG: IsSaved value is: \(IsSaved)")
                        }
                    }
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
            .background(Color.additional_50)
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(questionList: [Question(id: "2", category: "Cate", question: "que", type: "product", timestamp: Date()),
                                Question(id: "55", category: "CAte2", question: "que2", type: "product", timestamp: Date())])
    }
}
