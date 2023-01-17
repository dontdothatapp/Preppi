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
        VStack (alignment: .leading){
            Image("\(page.imageUrl)")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea(.all, edges: .top)
            HStack {
                Text(page.name)
                    .foregroundColor(.text_900)
                    .font(.system(size: 40))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 20)
                    //.frame(width: 400)
                    //.padding(.trailing, 20)
                Spacer()
            }
            .padding(.bottom, 24)
            
            HStack {
                Text(page.description)
                    .foregroundColor(.text_900)
                    .font(.headline)
                    .fontWeight(.medium)
                    .padding(.leading, 20)
                Spacer()
            }
            Spacer()
        }
    }
}

struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView(page: Page.samplePage)
    }
}
