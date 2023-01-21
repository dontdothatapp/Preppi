//
//  TestGPT.swift
//  Preppi
//
//  Created by Степан Величко on 21.01.2023.
//

import SwiftUI

struct FirstView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("first-screen-image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding(.top, 50)
    
                Text("First Screen")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
    
                Text("This is the first screen of the app. It contains some information")
                    .padding()
    
                NavigationLink(destination: SecondView()) {
                    Text("Go to Second Screen")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(5)
                        .padding(.top, 20)
                }
            }
        }
    }
}

struct SecondView: View {
    var body: some View {
        VStack {
            Image("second-screen-image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .padding(.top, 50)

            Text("Second Screen")
                .font(.largeTitle)
                .padding(.bottom, 20)

            Text("This is the second screen of the app. It contains some information")
                .padding()

            NavigationLink(destination: Text("Congrats!").font(.largeTitle)) {
                Text("Show Congrats")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(5)
                    .padding(.top, 20)
            }
        }
    }
}


struct TestGPT_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
