//
//  SigninView.swift
//  Preppi
//
//  Created by Степан Величко on 21.01.2023.
//

import SwiftUI

struct LoginView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        NavigationView {
            VStack {
                Image("signup_reg")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea(.all, edges: .top)
                    .padding(.horizontal, 10)
                
                HStack {
                    Text("Welcome back")
                        .foregroundColor(.text_900)
                        .font(.system(size: 40, design: .rounded))
                        .fontWeight(.medium)
                        .kerning(3.0)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 20)
                    Spacer()
                }
                .padding(.bottom, 24)

                VStack(alignment: .leading) {
                    
                    TextField("Email", text: $email)
                        .foregroundColor(.text_900)
                        .textFieldStyle(.plain)
                        .placeholder(when: email.isEmpty) {
                            Text("Email")
                                .foregroundColor(.text_500)
                        }
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.text_300)
                        .padding(.bottom, 20)

                    SecureField("Password", text: $password)
                        .foregroundColor(.text_900)
                        .textFieldStyle(.plain)
                        .placeholder(when: password.isEmpty) {
                            Text("Password")
                                .foregroundColor(.text_300)
                        }
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.text_300)
                    
                    }
                    .padding(.horizontal, 20)

                Spacer()
                
                
                //Create account button - Sign up
                Button {
                    //sign up
                } label: {
                    HStack {
                        Text("Log in")
                            .foregroundColor(.white)
                    }
                    .frame(width: 350, height: 50)
                    .background(
                        Color.primary_900
                            .cornerRadius(8)
                        )
                }

                //Sign in with Apple button
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.white.opacity(0.1))
                
                /*
                Button {
                    print("Sign in with Apple")
                } label: {
                    SignInWithAppleButton()
                        .frame(width: 250, height: 50)
                        .cornerRadius(8)
                        .foregroundColor(.black)
                }
                */
                 
                NavigationLink(destination: ContentView()) {
                    SignInWithAppleButton()
                        .frame(width: 250, height: 50)
                        .cornerRadius(8)
                        .foregroundColor(.black)
                }

                Spacer()
                HStack {
                    Text("Don't have account yet? ")
                        .font(.subheadline)

                    Button(action: {
                        // handle sign in page navigation
                    }) {
                        Text("Sign up")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.top, 20)
            }
        }
        .navigationBarHidden(true)
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
