//
//  RadioButton.swift
//  Preppi
//
//  Created by Степан Величко on 24.02.2023.
//

import SwiftUI

struct RadioButton: View {
    
    @Binding var selected: Int
    @State var withDiscount: Bool
    @State var id: Int
    @State var planName: String
    @State var price: String
    
    var body: some View {
        Button(action: {
            self.selected = self.id
        }) {
            HStack(spacing: 10) {
                Image(systemName: selected == id ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(selected == id ? .primary_500 : .text_700)
                
                Text(planName)
                    .font(.system(size: 16))
                    .foregroundColor(.text_700)
                    .fontWeight(.regular)
                
                if withDiscount {
                    Text("-33%")
                        .font(.system(size: 14))
                        .foregroundColor(.text_50)
                        .frame(width: 44, height: 18)
                        .background(Color.primary_500)
                        .cornerRadius(4)
                }
                
                Spacer()
                Text(price)
                    .font(.system(size: 15))
                    .foregroundColor(.text_700)
                    .fontWeight(.regular)
                
            } .padding(.leading, 40) .padding(.trailing, 40)
        }
    }
}

struct RadioButton_Previews: PreviewProvider {
    
    @State static var selectedOption = 1
    @State static var discount = true
    
    static var previews: some View {
        RadioButton(selected: $selectedOption, withDiscount: true, id: 1, planName: "3-months", price: "€19,99/One-time")
    }
}
