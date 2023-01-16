//
//  ContentView.swift
//  Preppi
//
//  Created by Степан Величко on 16.01.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var pageIndex = 0
    private let pages: [Page] = Page.samplePages
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        TabView(selection: $pageIndex) {
            ForEach(pages) { page in
                VStack {
                    Spacer()
                    OnboardingPageView(page: page)
                    Spacer()
                    if page == pages.last {
                        Button("Start practicing", action: goToZero)
                            .buttonStyle(.bordered)
                    } else {
                        Button("Next", action: incrementPage)
                    }
                }
            }
        }
    }
    
    func incrementPage() {
        pageIndex += 1
    }
    
    func goToZero() {
        pageIndex = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

