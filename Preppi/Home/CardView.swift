//
//  CardView.swift
//  Preppi
//
//  Created by Степан Величко on 21.01.2023.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        VStack {
            VStack {
                Spacer()
                
                //Tag
                HStack {
                    Text("behavioral")
                        .padding(.leading, 15)
                        .padding(.top, 40)
                        .underline()
                        .foregroundColor(Color.secondary_500)
                    Spacer()
                }
                
                //Main text
                HStack {
                    Text("Tell me about a time you had to make a decision to make short-term sacrifices for long-term gains.")
                        .font(.title)
                        .foregroundColor(.text_900)
                        .padding(15)
                        .padding(.bottom, 30)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                Spacer()
                
                //Save & Mastered buttons
                HStack{
                    Spacer()
                    HStack{
                        Image(systemName: "bookmark")
                        Text("Save")
                    }
                    Spacer()
                    HStack{
                        Image(systemName: "wand.and.stars")
                        Text("Mastered")
                    }
                    Spacer()
                }
                .padding(.bottom, 30)
            }
            .frame(minWidth: 320, idealWidth: 340, maxWidth: 340, minHeight: 350, idealHeight: 350, maxHeight: 400, alignment: .leading)
            .background{
                Color.primary_50
            }
            .cornerRadius(30)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
