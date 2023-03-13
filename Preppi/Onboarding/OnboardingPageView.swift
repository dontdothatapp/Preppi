//
//  OnboardingPageView.swift
//  Preppi
//
//  Created by Степан Величко on 16.01.2023.
//

import SwiftUI
import Mixpanel

struct OnboardingPageView: View {
    var page: Page
    
    var body: some View {
        VStack (alignment: .leading){
            Image("\(page.imageUrl)")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea(.all, edges: .top)
                .padding(.horizontal, 10)
            HStack {
                Text(page.name)
                    .foregroundColor(.text_900)
                    .font(.system(size: 40, design: .rounded))
                    .fontWeight(.medium)
                    .kerning(3.0)
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
                    //.font(.headline)
                    .font(.system(size: 17, design: .rounded))
                    .fontWeight(.medium)
                    .baselineOffset(3)
                    .padding(.leading, 20)
                Spacer()
            }
            Spacer()
        } .onAppear {
            Mixpanel.mainInstance().track(event: "Onboarding screen viewed", properties: [
                "Type": "Screen",
                "Title": page.name,
                "Step": page.tag
            ])
        }
    }
}

struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView(page: Page.samplePage)
    }
}
