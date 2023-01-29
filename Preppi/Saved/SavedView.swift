//
//  SavedView.swift
//  Preppi
//
//  Created by Степан Величко on 21.01.2023.
//

import SwiftUI

struct SavedView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.additional_50
                    .ignoresSafeArea(.all)
                
                VStack {
                    ChipsView()
                    
                    Spacer()
                    
                    ScrollView(.vertical, showsIndicators: false){
                        
                        VStack{
                            Question(category: "product strategy", question: "Amazon is launching free storage for photos. If you're a Google PM for Photos, what would you do?")
                            Question(category: "analytical", question: "What metrics would you focus on as the PM for YouTube?")
                            Question(category: "product strategy", question: "How would you monetize Facebook Dating?")
                            Question(category: "product design", question: "What's your favorite product and why?")
                            Question(category: "behavioral", question: "Tell me about a time you had a conflict with someone. How did you resolve it and what did you learn?")
                            Question(category: "product strategy", question: "Amazon is launching free storage for photos. If you're a Google PM for Photos, what would you do?")
                            Question(category: "analytical", question: "What metrics would you focus on as the PM for YouTube?")
                            Question(category: "product strategy", question: "How would you monetize Facebook Dating?")
                            Question(category: "Execution", question: "You are a PM for Instagram Stories. You are considering to increase the expiration time of Stories. What metrics would you look at to make this decision?")
                        }
                        
                    }
                    
                    Spacer()
                }
                
                
            } .navigationTitle("Saved")
        }
    }
}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView()
    }
}
