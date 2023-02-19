//
//  SavedView.swift
//  Preppi
//
//  Created by Степан Величко on 21.01.2023.
//

import SwiftUI
import Firebase

struct SavedView: View {
    
    @ObservedObject var questionModel = QuestionModel()
    @State private var questions = [Question]()
    
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
                            
                            if questions.count < 1 {
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
                                }
                            } else {
                                //All questions
                                ForEach(questions) { question in
                                    QuestionView(category: question.category, question: question.question, id: question.id, timestamp: question.timestamp)
                                }
                            }
                        } .padding(.top, 20)
                        
                    }
                    
                    Spacer()
                }
                .onAppear(perform: fetchSavedQuestions)
                
            } .navigationTitle("Saved")
        }
    }
    
    func fetchSavedQuestions() {
        questionModel.getSavedQuestions { (questions) in
        self.questions = questions
      }
    }
    
}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView().onAppear(perform: {
              SavedView().fetchSavedQuestions()
            })
    }
}
