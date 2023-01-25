//
//  ContentView.swift
//  Preppi
//
//  Created by Степан Величко on 16.01.2023.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State private var pageIndex = 0
    private let pages: [Page] = Page.samplePages
    private let dotAppearance = UIPageControl.appearance()
    
    @State private var userIsLoggedIn = false
    
    var body: some View {
        if userIsLoggedIn {
            //open the main screen
            HomeView()
        } else {
            content
        }
    }
    
    var content: some View {
        NavigationView {
            ZStack {
                
                //Background color
                Color.additional_50
                    .ignoresSafeArea(.all)
                
                //Onboarding page content
                TabView(selection: $pageIndex) {
                    ForEach(pages) { page in
                        VStack {
                            OnboardingPageView(page: page)
                            Spacer()
                            if page == pages.last {
                                
                                //Rectangle Button on the final step
                                NavigationLink {
                                    SignupView()
                                        .navigationBarHidden(true)
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
                                
                                /*
                                Button {
                                    //goToZero()
                                    //SignupView()
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
                                } */
                                .padding(.bottom, 50)
                            } else {
                                
                                //Circle Button on the first two steps
                                Button {
                                    incrementPage()
                                } label: {
                                        Circle()
                                            .frame(width: 68)
                                            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 2, y:4)
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
        .onAppear{
            Auth.auth().addStateDidChangeListener {  auth, user in
                if user != nil {
                    userIsLoggedIn.toggle()
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

