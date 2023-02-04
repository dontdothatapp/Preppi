//
//  TempCardView.swift
//  Preppi
//
//  Created by Степан Величко on 04.02.2023.
//

import SwiftUI

struct TempCardView: View {
        let questionList: [Question]

        @State private var currentQuestion: Question?

        var body: some View {
            if let question = currentQuestion {
                return AnyView(VStack {
                    CardView(question: question)
                    Button(action: {
                        if !questionList.isEmpty {
                            self.currentQuestion = questionList.randomElement()
                        }
                    }) {
                        Text("Next Question")
                    }
                })
            } else if !questionList.isEmpty {
                currentQuestion = questionList.randomElement()
                return AnyView(VStack {
                    CardView(question: currentQuestion!)
                    Button(action: {
                        if !questionList.isEmpty {
                            self.currentQuestion = questionList.randomElement()
                        }
                    }) {
                        Text("Next Question")
                    }
                })
            } else {
                return AnyView(Text("No questions available"))
            }
        }
    }




    
    struct TempCardView_Previews: PreviewProvider {
        static var previews: some View {
            TempCardView(questionList: [Question(id: "2", category: "Cate", question: "que"),
                                        Question(id: "55", category: "CAte2", question: "que2")])
        }
    }
