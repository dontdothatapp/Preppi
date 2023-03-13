//
//  Question.swift
//  Preppi
//
//  Created by Степан Величко on 29.01.2023.
//

import SwiftUI
import Mixpanel

struct QuestionView: View {
    
    @State var category: String
    @State var question: String
    @State var id: String
    @State var timestamp: Date
    @ObservedObject var questionModel = QuestionModel()
    
    var body: some View {
        VStack {
            VStack{
                HStack {
                    Text(category)
                    
                    Spacer()
                    
                    Button{
                        questionModel.deleteSavedQuestion(questionId: id)
                        Mixpanel.mainInstance().track(event: "Delete from saved", properties: [
                            "Type": "Button",
                            "Category": "Saved",
                            "Screen": "Saved"
                        ])
                    } label: {
                        Image(systemName: "heart.fill")
                    }
                }
                    .foregroundColor(.text_500)
                    .font(.system(size: 15))
                    .fontWeight(.light)
                //                HStack{
                //                    Text("\(timestamp)")
                //                        .foregroundColor(.text_500)
                //                        .font(.system(size: 15))
                //                        .fontWeight(.light)
                //                    Spacer()
                //                }
                HStack {
                    Text(question)
                        .foregroundColor(.text_900)
                        .font(.system(size: 17))
                        .fontWeight(.regular)
                    Spacer()
                }
                
                //Line divider
                HStack {
                    Rectangle()
                    //.padding(.leading, 20)
                        .frame(width: 300, height: 0.5)
                        .foregroundColor(.text_300)
                    Spacer()
                } .padding(.bottom, 20)
            } .frame(width: 350)
        }
    }
}

struct Question_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(category: "test category", question: "Very long text question to check how the view will work. Is it looking good?", id: "123", timestamp: Date())
    }
}
