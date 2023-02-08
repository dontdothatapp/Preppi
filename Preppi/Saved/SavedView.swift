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
    @State var unsavedQuestions = [Question]()
    @ObservedObject var selectedCategory = SelectedCategory()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.additional_50
                    .ignoresSafeArea(.all)
                
                VStack {
                    ChipsView()
                    Spacer()
                    ScrollView(.vertical, showsIndicators: false){
                        VStack{
                            if selectedCategory.selectedCategory == "" {
                                //All questions
                                ForEach(questions) { question in
                                    QuestionView(category: question.category, question: question.question)
                                }
                            } else {
                                //Only Saved questions filtered by selected category
                                Text("DEBUG: Selected category: \(selectedCategory.selectedCategory)")
                                    .font(.title2)
                                    .padding(.top, 40)
                                Text("Number of questions: \(questionModel.savedByCategory.count) 👇")
                                
                                ForEach(questionModel.savedByCategory, id: \.id) { item in
                                    QuestionView(category: item.category, question: item.question)
                                } .onAppear(perform: fetchSavedQuestions)
                            }
                            
                            //All unsaved questions
                            Text("DEBUG: Unsaved questions")
                                .font(.title2)
                                .padding(.top, 40)

                            Text("Number of questions: \(unsavedQuestions.count) 👇")
                                .padding(.bottom, 20)

                            ForEach(unsavedQuestions, id: \.id) { item in
                                QuestionView(category: item.category, question: item.question)
                            }
                        } //.padding(.bottom, 30)
                        
                    }
                    
                    Spacer()
                }
                .onAppear(perform: fetchSavedQuestions)
                .onAppear{
                    self.questionModel.getUnsavedQuestions { questions in
                        self.unsavedQuestions = questions
                    }
                }
//                .onAppear{
//                    self.questionModel.getSavedQuestionsByCategory(category: questionModel.selectedCategory) { items in
//                        self.savedByCategory = items
//
//                    }
//                }
                
                
            } .navigationTitle("Saved")
        }
    }
    
    init() {
        questionModel.getData()
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
