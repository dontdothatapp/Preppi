//
//  TempSavedView.swift
//  Preppi
//
//  Created by Степан Величко on 05.02.2023.
//

import SwiftUI

struct TempSavedView: View {
  @State private var questions = [Question]()

  var body: some View {
      VStack {
          Text("\(questions.count)")
          ForEach(questions, id: \.id) { question in
          Text(question.category)
        }
      }
      .onAppear(perform: fetchBookmarkedQuestions)
  }

  func fetchBookmarkedQuestions() {
    getBookmarkedQuestions { (questions) in
      self.questions = questions
    }
  }
}


struct TempSavedView_Previews: PreviewProvider {
    static var previews: some View {
        TempSavedView().onAppear(perform: {
              TempSavedView().fetchBookmarkedQuestions()
            })
    }
}
