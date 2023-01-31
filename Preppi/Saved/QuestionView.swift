//
//  Question.swift
//  Preppi
//
//  Created by Степан Величко on 29.01.2023.
//

import SwiftUI

struct QuestionView: View {
    
    @State var category: String
    @State var question: String
    
    var body: some View {
        VStack {
            VStack{
                HStack {
                    Text(category)
                        .foregroundColor(.text_500)
                        .font(.system(size: 15))
                        .fontWeight(.light)
                    Spacer()
                }
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
        QuestionView(category: "product strategy", question: "Amazon is launching free storage for photos. If you're a Google PM for Photos, what would you do?")
    }
}
