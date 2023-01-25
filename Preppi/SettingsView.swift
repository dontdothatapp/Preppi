//
//  SettingsView.swift
//  Preppi
//
//  Created by Степан Величко on 25.01.2023.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Button {
            //
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
