//
//  TempStatBlockView.swift
//  Preppi
//
//  Created by Степан Величко on 08.02.2023.
//

import SwiftUI

struct TempStatBlockView: View {
    
    @State var category: String
    @State var total: Int
    @State var mastered: Int
    
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
                    Text("Total: \(total) –> Mastered: \(mastered)")
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

struct TempStatBlockView_Previews: PreviewProvider {
    static var previews: some View {
        TempStatBlockView(category: "tempCategory", total: 8, mastered: 3)
    }
}
