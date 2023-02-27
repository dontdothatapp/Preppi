//
//  SigninView.swift
//  Preppi
//
//  Created by Степан Величко on 21.01.2023.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @State var showResetSheet = false
    
    var body: some View {
        NavigationView {
            ZStack {
                //Background color
                Color.additional_50
                    .ignoresSafeArea(.all)
                
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
                            .foregroundColor(.text_500)
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
                            .foregroundColor(.text_500)
                            .textFieldStyle(.plain)
                            .placeholder(when: password.isEmpty) {
                                Text("Password")
                                    .foregroundColor(.text_500)
                            }
                        Rectangle()
                            .frame(width: 350, height: 1)
                            .foregroundColor(.text_300)
                        
                        HStack {
                            Spacer()
                            
                            Button {
                                showResetSheet = true
                            } label: {
                                Text("Forgot password?")
                                    .foregroundColor(.text_500)
                                    .font(.system(size: 16))
                                    .padding(.top, 10)
                            }
                        }
                        
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    
                    //Login - Log in button
                    Button{
                        viewModel.login(withEmail: email, password: password)
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
                    
                    Button {
                        viewModel.login(withEmail: email, password: password)
                    } label: {
                        SignInWithAppleButton()
                            .frame(width: 250, height: 50)
                            .cornerRadius(8)
                            .foregroundColor(.black)
                    }
                    
                    NavigationLink {
                        SignupView()
                            .navigationBarHidden(true)
                    } label: {
                        HStack{
                            Text("Already have an account?")
                                .font(.subheadline)
                                .foregroundColor(Color.text_700)
                            
                            Text("Sign up")
                                .font(.subheadline)
                        }
                    }
                    .padding(.top, 80)
                }
                .sheet(isPresented: $showResetSheet) {
                    ResetPasswordView()
                        .presentationDetents([.medium, .large])
                }
            } .alert("Whoops!", isPresented: $viewModel.hasError) {
            } message: {
                Text(viewModel.errorMessage)
            }
        }
        .navigationBarHidden(true)
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
