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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
