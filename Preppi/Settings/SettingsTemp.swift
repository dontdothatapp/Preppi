//
//  SettingsTemp.swift
//  Preppi
//
//  Created by Степан Величко on 31.01.2023.
//

import SwiftUI

struct SettingsTemp: View {
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
            ZStack{
                Color.additional_50
                    .ignoresSafeArea(.all)
                
                VStack{
                    
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
                    }
            }
    }
}

struct SettingsTemp_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTemp(user: User(id: NSUUID().uuidString, name: "PreviewName", email: "preview@email.com"))
    }
}
