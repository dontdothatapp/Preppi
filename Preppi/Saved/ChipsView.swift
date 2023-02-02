//
//  ChipsView.swift
//  Preppi
//
//  Created by Степан Величко on 29.01.2023.
//

import SwiftUI
import Firebase

struct ChipsView: View {
    
    @ObservedObject var questionModel = QuestionModel()
    
    
    //var uniquechips = Array(Set(QuestionModel().questionList.map {Categories(id: $0.category)}))
    
    //let uniqueCategories = Array(Set(cardsModelArray.map {Categories(id: $0.category)}))
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                
                //Start session
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        HStack{
                            Image(systemName: "play.fill")
                            Text("Start session")
                                .foregroundColor(.text_900)
                                .font(.system(size: 15))
                                .fontWeight(.light)
                            //.padding(.horizontal, 5)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Capsule().stroke(Color.primary_900,lineWidth: 2))
                        .padding(.vertical)
                        .padding(.leading, 20)
                        
                        HStack {
                            let uniqueCategories = questionModel.getUniqueCategories()
                            ForEach(uniqueCategories, id: \.self) { item in
                                Chips(chipsName: item.self)
                            }
                        } .padding(.trailing, 20)
                    }
                }
            }
            .padding(.top, 20)
        }
    }
    
    init() {
        questionModel.getData()
    }
    
}

struct ChipsView_Previews: PreviewProvider {
    static var previews: some View {
        ChipsView()
    }
}
