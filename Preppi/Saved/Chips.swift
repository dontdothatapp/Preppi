//
//  Chips.swift
//  Preppi
//
//  Created by Степан Величко on 29.01.2023.
//

import SwiftUI

struct Chips: View {
    
    @State var chipsName: String
    
    var body: some View {
        VStack {
            HStack{
                Text(chipsName)
                    .foregroundColor(.text_500)
                    .font(.system(size: 15))
                    .fontWeight(.light)
                    //.padding(.horizontal, 5)
            }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Capsule().stroke(Color.secondary_300,lineWidth: 1))
            
//            Label("Start session", systemImage: "play.fill")
//                .padding(.horizontal)
//                .padding(.vertical, 10)
//                .background(Color.primary_900)
//                .foregroundColor(.white)
//                .cornerRadius(14)
        }
    }
}

struct Chips_Previews: PreviewProvider {
    static var previews: some View {
        Chips(chipsName: "behavioral")
    }
}
