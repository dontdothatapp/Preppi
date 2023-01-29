//
//  CardView.swift
//  Preppi
//
//  Created by Степан Величко on 21.01.2023.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        
        ZStack {
            Rectangle()
                .frame(minWidth: 320, idealWidth: 340, maxWidth: 340, minHeight: 310, idealHeight: 310, maxHeight: 350, alignment: .leading)
                .foregroundColor(.white)
                .cornerRadius(30)
                .padding(.top, 24)
                .shadow(color: Color.gray.opacity(0.1), radius: 10, x: 0, y: 4)
            
            VStack {
                Spacer()
                
                //Tag
                HStack {
                    Text("behavioral")
                    //.padding(.leading, 40)
                    //.padding(.top, 40)
                        .padding(.bottom, 10)
                        .underline()
                        .foregroundColor(Color.secondary_500)
                    Spacer()
                }
                .padding(.leading, 20)
                
                //Main text
                HStack {
                    Text("Tell me about a time you had to make a decision to make short-term sacrifices for long-term gains.")
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
                            Text("Save")
                            
                        } .foregroundColor(.text_900) .padding(.leading, 20) .padding(.trailing, 35)
                    }
                    
                    //Mastered button
                    Button {
                        //
                    } label: {
                        HStack{
                            Image(systemName: "wand.and.stars")
                            Text("Mastered")
                        } .foregroundColor(.text_900)
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 20)
            } .frame(minWidth: 320, idealWidth: 340, maxWidth: 340, minHeight: 310, idealHeight: 310, maxHeight: 350, alignment: .leading)
        }
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
