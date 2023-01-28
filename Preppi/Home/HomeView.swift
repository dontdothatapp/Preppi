//
//  HomeView.swift
//  Preppi
//
//  Created by Степан Величко on 21.01.2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                
                //Menu button
                HStack {
                    Spacer()
                    
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .padding(.trailing, 27)
                            .foregroundColor(Color.text_900)
                    }
                }.padding(.top, 20)
                Spacer()
                
                CardView()
                Spacer()
                
                //New Question button
                NavigationLink {
                    ContentView()
                        .navigationBarHidden(true)
                } label: {
                    HStack {
                        Image(systemName: "arrow.triangle.2.circlepath")
                        Text("New question")
                    }
                    .foregroundColor(Color.text_50)
                    .frame(width: 350, height: 50)
                    .background(
                        Color.primary_900
                            .cornerRadius(8)
                    )
                }
                Spacer()
                
            }
            .background(Color.additional_50)
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
