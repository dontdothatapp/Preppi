//
//  OnboardingPageView.swift
//  Preppi
//
//  Created by Степан Величко on 16.01.2023.
//

import SwiftUI

struct OnboardingPageView: View {
    var page: Page
    
    var body: some View {
        VStack(spacing: 20) {
            Image("\(page.imageUrl)")
                .resizable()
                .scaledToFit()
            Text(page.name)
                .font(.title)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            
            Text(page.description)
                .font(.subheadline)
                //.frame(width: 400)
                .padding(.leading, 20)
                .padding(.trailing, 20)
        }
    }
}

struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView(page: Page.samplePage)
    }
}
