//
//  QuestionForAnalyticsView.swift
//  Preppi
//
//  Created by Степан Величко on 18.02.2023.
//

import SwiftUI

struct QuestionForAnalyticsView: View {
    
    @State var question: String
    @State var id: String
    @ObservedObject var questionModel = QuestionModel()
    
    var body: some View {
        VStack {
            VStack{
                
                HStack {
                    Text(question)
                        .foregroundColor(.text_900)
                        .font(.system(size: 17))
                        .fontWeight(.regular)
                    Spacer()
                    Button{
                        questionModel.deleteMasteredQuestion(questionId: id)
                    } label: {
                        Image(systemName: "trash.fill")
                    }
                        .foregroundColor(.text_500)
                        .font(.system(size: 15))
                        .fontWeight(.light)
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

struct QuestionForAnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionForAnalyticsView(question: "test Question view for preview of the QuestionForAnalyticsView", id: "test_id")
    }
}
