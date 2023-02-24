//
//  PremiumView.swift
//  Preppi
//
//  Created by Степан Величко on 24.02.2023.
//

import SwiftUI

struct PremiumView: View {

    @State private var selectedOption = 0
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.additional_50
                .ignoresSafeArea(.all)

                //Image
                VStack (alignment: .leading){
                    Image("confetti")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 308)
                        .ignoresSafeArea(.all, edges: .top)
                        .padding(.horizontal, 10)
                        .blur(radius: 0)
                    Spacer()
                }
            LinearGradient(
                gradient: Gradient(colors: [Color.additional_50.opacity(0.0), Color.additional_50]),
                startPoint: .top,
                endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack{
                //Xmark – close button
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .padding(.leading, 20)
                            .foregroundColor(Color.text_900)
                        Spacer()
                    }
                }
                
                //Cards and Terms
                ScrollView(showsIndicators: false) {
                    VStack {

                        //Main card
                        ZStack {
                            Rectangle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.white, Color.white.opacity(0.3)]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing)
                                )
                                .blur(radius: 1)
                                .frame(width: 350, height: 328)
                                .cornerRadius(30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color.white, Color.white.opacity(0.4)]),
                                                startPoint: .topTrailing,
                                                endPoint: .bottomLeading),
                                            lineWidth: 0.5
                                        )
                                )
                                .padding(.top, 24)
                                .shadow(color: Color.gray.opacity(0.1), radius: 10, x: 0, y: 4)
                            VStack{
                                Text("Learn efficiently")
                                    .foregroundColor(.text_900)
                                    .font(.system(size: 34))
                                    .fontWeight(.bold)
                                    .padding(.bottom, 1)
                                
                                Rectangle()
                                    .frame(width: 218, height: 0.5)
                                    .foregroundColor(.text_50)
                                
                                //Premium benefits
                                HStack{
                                    VStack(alignment: .leading, spacing: 20) {
                                        PremiumLine(caption: "Unlimited saved")
                                        PremiumLine(caption: "Access to all questions")
                                        PremiumLine(caption: "Progress tracking")
                                        PremiumLine(caption: "Tags search")
                                    } .padding(.leading, 60)
                                    Spacer()
                                } .padding(.top, 40)
                            }
                        } .padding(.top, 138)
                        
                        //Pricing options
                        ZStack {
                            Rectangle()
                                .frame(width: 350, height: 110)
                                .foregroundColor(.white)
                                .cornerRadius(30)
                                .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 4)
                            VStack (alignment: .leading) {
                                RadioButton(selected: $selectedOption, withDiscount: true, id: 0, planName: "3-months", price: "€19,99/ One-time")
                                    .padding(.bottom, 5)
                                Rectangle()
                                    .frame(width: 290, height: 0.5)
                                    .foregroundColor(.text_50)
                                    .padding(.horizontal, 50)
                                RadioButton(selected: $selectedOption, withDiscount: false, id: 1, planName: "Weekly", price: "€4,99/week")
                                    .padding(.top, 5)
                            }
                            
                        } .padding(.top, 10)
                        
                        //Terms and Conditions
                        VStack (alignment: .leading){
                            Text("By subscribing to Preppi Premium you agree to the Preppi Terms of Service and Privacy Policy.")
                                .foregroundColor(Color.text_500)
                                .font(.system(size: 14))
                            Text("Restore Purchases")
                                .foregroundColor(Color.text_500)
                                .font(.system(size: 14))
                                .padding(.top, 5)
                        } .padding(.horizontal, 20)
                    }
                }
                
                //Subscription Button
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Text("Subscribe for € 19,99 / one-time")
                    }
                    .foregroundColor(Color.text_50)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .frame(width: 350, height: 50)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.primary_700, Color.primary_500]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing)
                        .cornerRadius(16)
                        .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 4)
                    )
                }
            }
        }
    }
}

struct PremiumView_Previews: PreviewProvider {
    static var previews: some View {
        PremiumView()
    }
}
