//
//  HomeView.swift
//  Preppi
//
//  Created by Степан Величко on 21.01.2023.
//

import SwiftUI

struct HomeView: View {
    
    let questionList: [Question]
    
    var body: some View {
        NavigationView {
            VStack {
                
                //Menu button
                HStack {
                    Spacer()
                    
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .padding(.trailing, 27)
                            .foregroundColor(Color.text_900)
                    }
                }.padding(.top, 60).padding(.bottom, 10)
                //Spacer()
                
//                CardView(question: questionList.randomElement()!)
                if !questionList.isEmpty, let question = questionList.randomElement() {
                                CardView(question: question)
                            }
                Spacer()
                
                //New Question button
                Button {
                    //
                } label: {
                    HStack {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .foregroundColor(.primary_900)
                        Text("New question")
                    }
                    .foregroundColor(Color.text_900)
                    .frame(width: 350, height: 50)
                    .background(
                        Color.additional_50
                            .cornerRadius(16)
                            .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 4)
                    )
                }
                
                Spacer()
                
            }
            .background(Color.additional_50)
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(questionList: [Question(id: "2", category: "Cate", question: "que"),
                               Question(id: "55", category: "CAte2", question: "que2")])
    }
}
