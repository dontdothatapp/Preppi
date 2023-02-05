//
//  CardView.swift
//  Preppi
//
//  Created by Степан Величко on 21.01.2023.
//

import SwiftUI

struct CardView: View {
    
    //@ObservedObject var questionModel = QuestionModel()
    
    let question: Question
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(minWidth: 320, idealWidth: 340, maxWidth: 340, minHeight: 310, idealHeight: 310, maxHeight: 350, alignment: .leading)
                .foregroundColor(.additional_50)
                .cornerRadius(16)
                .padding(.top, 24)
                .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 4)
            
            VStack {
                Spacer()
                
                //Tag
                HStack {
                    Text(question.category)
                    //.padding(.leading, 40)
                    //.padding(.top, 40)
                        .padding(.bottom, 10)
                        .underline()
                        .foregroundColor(Color.text_500)
                    Spacer()
                }
                .padding(.leading, 20)
                
                //Main text
                HStack {
                    Text(question.question)
                        .font(.title)
                        .foregroundColor(.text_900)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.leading, 20)
                //.offset(y: 20)
                Spacer()
                
                //Save & Mastered buttons
                HStack{
                    
                    //Save button
                    Button {
                        //
                    } label: {
                        HStack{
                            Image(systemName: "bookmark")
                                .foregroundColor(.primary_900)
                            Text("Save")
                                .foregroundColor(.text_900)
                            
                        }  .padding(.leading, 20) .padding(.trailing, 35)
                    }
                    
                    //Mastered button
                    Button {
                        //
                    } label: {
                        HStack{
                            Image(systemName: "wand.and.stars")
                                .foregroundColor(.primary_900)
                            Text("Mastered")
                                .foregroundColor(.text_900)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 20)
            } .frame(minWidth: 320, idealWidth: 340, maxWidth: 340, minHeight: 310, idealHeight: 310, maxHeight: 350, alignment: .leading)
        }
    }
    
//    init() {
//        questionModel.getData()
//    }
    
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(question: Question(id: "1", category: "test", question: "Sample question just an exaple for a preview", type: "product"))
    }
}
