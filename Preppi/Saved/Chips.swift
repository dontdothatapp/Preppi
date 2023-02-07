//
//  Chips.swift
//  Preppi
//
//  Created by Степан Величко on 29.01.2023.
//

import SwiftUI

struct Chips: View {
    
    @State var chipsName: String
    @State var selectedCategory: String = ""
    @ObservedObject var questionModel = QuestionModel()
    
    var body: some View {
        VStack {
            HStack{
                
                Button {
                    questionModel.selectedCategory = chipsName
                    print("DEBUG: selected category: \(questionModel.selectedCategory)")
                    questionModel.getSavedQuestionsByCategory { items in
                        questionModel.savedByCategory = items
                    }
                    print("DEBUG: saved by category items: \(questionModel.savedByCategory)")
                } label: {
                    Text(chipsName)
                        .foregroundColor(.text_700)
                        .font(.system(size: 15))
                        .fontWeight(.light)
                        //.padding(.horizontal, 5)
                }
                
//                .onAppear{
//                    self.questionModel.getSavedQuestionsByCategory(category: questionModel.selectedCategory) { items in
//                        self.savedByCategory = items
//
//                    }
//                }
                
                
//                Text(chipsName)
//                    .foregroundColor(.text_500)
//                    .font(.system(size: 15))
//                    .fontWeight(.light)
                    //.padding(.horizontal, 5)
            }
                .padding(.horizontal)
                .padding(.vertical, 8)
                //.background(Capsule().stroke(Color.text_300,lineWidth: 1))
        }
    }
}

struct Chips_Previews: PreviewProvider {
    static var previews: some View {
        Chips(chipsName: "behavioral")
    }
}
