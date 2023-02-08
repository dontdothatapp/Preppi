//
//  Chips.swift
//  Preppi
//
//  Created by Степан Величко on 29.01.2023.
//

import SwiftUI

struct Chips: View {
    
    @State var chipsName: String
    //@State var selectedCategory: String = ""
    @ObservedObject var questionModel = QuestionModel()
    @ObservedObject var selectedCategory = SelectedCategory()
    
    var body: some View {
        VStack {
            HStack{
                
                Button {
                    selectedCategory.selectedCategory = chipsName
                    print("DEBUG: selected category: \(selectedCategory.selectedCategory)")
                    
                    questionModel.getSavedQuestionsByCategory(category: selectedCategory.selectedCategory) { items in
                        questionModel.savedByCategory = items
                        print("DEBUG_2: inside the func: \(questionModel.savedByCategory)")
                    }
                    print("DEBUG: saved by category items: \(questionModel.savedByCategory)")
                } label: {
                    Text(chipsName)
                        .foregroundColor(.text_700)
                        .font(.system(size: 15))
                        .fontWeight(.light)
                        //.padding(.horizontal, 5)
                } .onChange(of: selectedCategory.selectedCategory) { newValue in
                    questionModel.getSavedQuestionsByCategory(category: newValue) { items in
                        questionModel.savedByCategory = items
                    }}
                
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
