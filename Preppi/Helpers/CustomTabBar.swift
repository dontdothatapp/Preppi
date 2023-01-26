//
//  TabBar.swift
//  Preppi
//
//  Created by Степан Величко on 26.01.2023.
//

import SwiftUI

enum Tabs: Int {
    case stats = 0
    case home = 1
    case save = 2
    
}

struct CustomTabBar: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View {
//        ZStack {
//            Color.additional_50
//                .edgesIgnoringSafeArea(.bottom)
            
            HStack{

                //Stats tab
                Button {
                    selectedTab = .stats
                } label: {
                    TabBarButton(imageName: "chart.bar.fill",
                                 isActive: selectedTab == .stats)
                }
                
                //Home tab
                Button {
                    selectedTab = .home
                } label: {
                    TabBarButton(imageName: "house.fill", isActive: selectedTab == .home)
                }
                
                //Save tab
                Button {
                    selectedTab = .save
                } label: {
                    TabBarButton(imageName: "bookmark.fill", isActive: selectedTab == .save)
                }
                
            }
            .frame(height: 64)
        }
    //}
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.home))
    }
}
