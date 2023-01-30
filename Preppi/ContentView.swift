//
//  ContentView.swift
//  Preppi
//
//  Created by Степан Величко on 16.01.2023.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State var selectedTab: Tabs = .home
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var pageIndex = 0
    private let pages: [Page] = Page.samplePages
    private let dotAppearance = UIPageControl.appearance()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @State private var userIsLoggedIn = false
    
    var body: some View {
        if viewModel.userSession == nil {
            //open the onboarding
            unloginView
        } else {
            ZStack{
                Color.additional_50
                    .ignoresSafeArea(.all)
                VStack{
                    //HomeView()
                    TabView(selection: $selectedTab) {
                        AnalyticsView()
                            .tabItem {
                                Text("Analytics")
                            }
                            .tag(Tabs.stats)
                        HomeView()
                            .tabItem {
                                Text("Home")
                            }
                            .tag(Tabs.home)
                        SavedView()
                            .tabItem {
                                Text("Saved")
                            }
                            .tag(Tabs.save)
                    }
                    CustomTabBar(selectedTab: $selectedTab)
                }
            }
        }
    }
    
    var unloginView: some View {
        NavigationView {
            
            //Onboarding page content
            TabView(selection: $pageIndex) {
                ForEach(pages) { page in
                    VStack {
                        OnboardingPageView(page: page)
                        Spacer()
                        
                        //Buttons logic: round button on the first two steps or rectangle on the last one
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
                    }
                    .tag(page.tag)
                } // Go through OnboardingPageModel and build required pages with a loop
            }
            .animation(.easeInOut, value: pageIndex)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .onAppear{
                dotAppearance.currentPageIndicatorTintColor = UIColor(Color.primary_900)
                dotAppearance.pageIndicatorTintColor = UIColor(Color.text_300)
            }
            .background(Color.additional_50)
        }
        //Check if we have user session/id or not
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
            .environmentObject(AuthViewModel())
    }
}

