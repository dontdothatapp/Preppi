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
        ZStack {
            //Background color
            Color.additional_50
                .ignoresSafeArea(.all)
            
            //Page content
            TabView(selection: $pageIndex) {
                ForEach(pages) { page in
                    VStack {
                        OnboardingPageView(page: page)
                        Spacer()
                        if page == pages.last {
                            
                            //Rectangle Button on the final step
                            Button {
                                goToZero()
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Start practicing")
                                        .foregroundColor(.white)
                                        .padding(.trailing, 50)
                                    Image(systemName: "arrow.right")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 20)
                                }
                                .frame(width: 350, height: 50)
                                .background(
                                    Color.primary_900
                                        .cornerRadius(8)
                                    )
                            }
                            .padding(.bottom, 50)
                        } else {
                            
                            //Circle Button on the first two steps
                            Button {
                                incrementPage()
                            } label: {
                                    Circle()
                                        .frame(width: 68)
                                        .shadow(color: Color.black.opacity(0.3), radius: 10)
                                        .overlay(
                                            Image(systemName: "arrow.right")
                                                .font(.title2)
                                                .foregroundColor(.white)
                                        )
                            }
                            .padding(.bottom, 50)
                        }
                        //Spacer()
                    }
                    //.ignoresSafeArea(.)
                    .tag(page.tag)
                }
            }
            .animation(.easeInOut, value: pageIndex)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .onAppear{
                dotAppearance.currentPageIndicatorTintColor = UIColor(Color.primary_900)
                dotAppearance.pageIndicatorTintColor = UIColor(Color.text_300)
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

