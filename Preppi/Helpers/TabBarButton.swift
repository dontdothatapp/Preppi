//
//  TabBarButton.swift
//  Preppi
//
//  Created by Степан Величко on 26.01.2023.
//

import SwiftUI

struct TabBarButton: View {
    
    var imageName: String
    var isActive: Bool
    
    var body: some View {
        GeometryReader { geo in
            if isActive {
            Rectangle()
                .cornerRadius(4)
                .foregroundColor(Color.primary_700)
                .frame(width: geo.size.width/2, height: 2)
                .padding(.leading, geo.size.width/4)
                
                Image(systemName: imageName + ".fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 34, height: 22)
                    .scaleEffect(1.15)
                .foregroundColor(Color.primary_700)
                .frame(width: geo.size.width, height: geo.size.height)
                
            } else {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 34, height: 22)
            .foregroundColor(Color.text_500)
            .frame(width: geo.size.width, height: geo.size.height)
                
            }
        }
    }
}

struct TabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        TabBarButton(imageName: "bookmark.fill", isActive: false)
    }
}
