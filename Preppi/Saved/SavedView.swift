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
                    ChipsView()
                    
                    Spacer()
                    
                    ScrollView(.vertical, showsIndicators: false){
                        
                        VStack{
                            
                            ForEach(questions) { question in
                                QuestionView(category: question.category, question: question.question)
                            }
                        }
                        
                    }
                    
                    Spacer()
                }
                .onAppear(perform: fetchSavedQuestions)
                
                
            } .navigationTitle("Saved")
        }
    }
    
    init() {
        questionModel.getData()
    }
    
    func fetchSavedQuestions() {
        getSavedQuestions { (questions) in
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
