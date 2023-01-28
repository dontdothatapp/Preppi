//
//  AnalyticsView.swift
//  Preppi
//
//  Created by Степан Величко on 21.01.2023.
//

import SwiftUI

struct AnalyticsView: View {
    var body: some View {
        ZStack {
            Color.additional_50
                .ignoresSafeArea(.all)
            
            Text("Stats screen")
                .foregroundColor(.text_900)
                .font(.system(size: 40, design: .rounded))
                .fontWeight(.medium)
                .kerning(3.0)
                .multilineTextAlignment(.leading)
            .padding(.leading, 20)
        }
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
    }
}
