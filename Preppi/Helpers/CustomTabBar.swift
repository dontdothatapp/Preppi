//
//  TabBar.swift
//  Preppi
//
//  Created by Степан Величко on 26.01.2023.
//

import SwiftUI

enum Tabs: String, CaseIterable {
    case stats
    case home
    case save
    
}

struct CustomTabBar: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View {
            
            HStack{

                //Stats tab
                Button {
                    selectedTab = .stats
                } label: {
                    TabBarButton(imageName: "chart.bar",
                                 isActive: selectedTab == .stats)
                }
                
                //Home tab
                Button {
                    selectedTab = .home
                } label: {
                    TabBarButton(imageName: "house", isActive: selectedTab == .home)
                }

                
                //Save tab
                Button {
                    selectedTab = .save
                } label: {
                    TabBarButton(imageName: "bookmark", isActive: selectedTab == .save)
                }
                
            }
            .frame(height: 64)
            .background(Color.additional_50)
        }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.home))
    }
}
