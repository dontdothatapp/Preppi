//
//  ResetPasswordView.swift
//  Preppi
//
//  Created by Степан Величко on 27.02.2023.
//

import SwiftUI
import Mixpanel

struct ResetPasswordView: View {
    
    @State private var email: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                //Background color
                Color.additional_50
                    .ignoresSafeArea(.all)
                
                VStack {
//                    Image("signup_reg")
//                        .resizable()
//                        .scaledToFit()
//                        .ignoresSafeArea(.all, edges: .top)
//                        .padding(.horizontal, 10)
                    
                    HStack {
                        Text("Reset password")
                            .foregroundColor(.text_900)
                            .font(.system(size: 40, design: .rounded))
                            .fontWeight(.medium)
                            .kerning(3.0)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 20)
                            .padding(.top, 60)
                        Spacer()
                    }
                    .padding(.bottom, 40)
                    
                    VStack(alignment: .leading) {
                        
                        TextField("Your email", text: $email)
                            .foregroundColor(.text_900)
                            .textFieldStyle(.plain)
                            .placeholder(when: email.isEmpty) {
                                Text("Your email")
                                    .foregroundColor(.text_500)
                            }
                        Rectangle()
                            .frame(width: 350, height: 1)
                            .foregroundColor(.text_300)
                            .padding(.bottom, 20)
                        
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    
                    //Reset password button
                    Button{
                        viewModel.resetPassword(withEmail: email)
                        Mixpanel.mainInstance().track(event: "reset password", properties: [
                            "Type": "Button",
                            "Category": "Auth"
                        ])
                    } label: {
                        HStack {
                            Text("Reset password")
                                .foregroundColor(.white)
                        }
                        .frame(width: 350, height: 50)
                        .background(
                            Color.primary_900
                                .cornerRadius(8)
                        )
                        .padding(.bottom, 60)
                    }
                }
            } .alert("Whoops!", isPresented: $viewModel.hasError) {
            } message: {
                Text(viewModel.errorMessage)
            }
            .alert("Check your email", isPresented: $viewModel.showResetAlert) {
                Button("Got it", role: .cancel) {
                    viewModel.showResetScreen = false
                }
            } message: {
                Text("We have sent a password reset instructions to your email")
            }
        } .onAppear {
            Mixpanel.mainInstance().track(event: "Reset password screen viewed", properties: [
                "Type": "Screen",
                "Category": "Auth"
            ])
        }
        .navigationBarHidden(true)
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
            .environmentObject(AuthViewModel())
    }
}
