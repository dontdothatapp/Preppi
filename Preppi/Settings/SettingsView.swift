//
//  SettingsView.swift
//  Preppi
//
//  Created by Степан Величко on 25.01.2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack{
            Color.additional_50
                .ignoresSafeArea(.all)
            
            VStack{
                
                if let user = viewModel.currentUser {
                    Spacer()
                    Text("Hey \(user.name) 👋")
                        .foregroundColor(.text_900)
                        .font(.system(size: 40, design: .rounded))
                        .fontWeight(.medium)
                        .kerning(3.0)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 20)
                        .padding(.bottom, 40)
                    Text("Your email is: \(user.email.lowercased())")
                        .foregroundColor(.text_900)
                        .font(.system(size: 17))
                        .fontWeight(.regular)
                    
                    Spacer()
                    
                    NavigationLink {
                        TempStatsView()
                    } label: {
                        Text("Temp stats view")
                            .font(.title2)
                            .padding(.trailing, 27)
                            .foregroundColor(Color.text_900)
                    }
                    
                    Button {
                        viewModel.signOut()
                    } label: {
                        HStack {
                            Text("Log out")
                        }
                        .foregroundColor(Color.text_50)
                        .frame(width: 350, height: 50)
                        .background(
                            Color.primary_900
                                .cornerRadius(8)
                        )
                    }
                    
                    Spacer()
                } else {
                    Button {
                        viewModel.signOut()
                    } label: {
                        HStack {
                            Text("Log out")
                        }
                        .foregroundColor(Color.text_50)
                        .frame(width: 350, height: 50)
                        .background(
                            Color.primary_900
                                .cornerRadius(8)
                        )
                    }
                }
            }
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AuthViewModel())
    }
}
