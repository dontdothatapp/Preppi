//
//  ChipsView.swift
//  Preppi
//
//  Created by Степан Величко on 29.01.2023.
//

import SwiftUI

struct ChipsView: View {
    var body: some View {
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
                    Chips(chipsName: "behavioral")
                    Chips(chipsName: "product design")
                    Chips(chipsName: "product strategy")
                    Chips(chipsName: "execution")
                    Chips(chipsName: "analytical")
                        .padding(.trailing, 20)
                }
            }
        }
        .padding(.top, 20)
    }
}

struct ChipsView_Previews: PreviewProvider {
    static var previews: some View {
        ChipsView()
    }
}
