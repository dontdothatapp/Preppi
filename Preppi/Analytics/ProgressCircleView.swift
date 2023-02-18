//
//  ProgressCircleView.swift
//  Preppi
//
//  Created by Степан Величко on 12.02.2023.
//

import SwiftUI

struct ProgressCircleView: View {
    
    let category: String
    let mastered: Int
    let total: Int
    
    var percentage: Double {
        return Double(mastered) / Double(total)
    }
    
    var body: some View {
        
        NavigationLink {
            MasteredCategoryView(selectedCategory: category)
        } label: {
            ZStack {
                
                Rectangle()
                    .frame(width: 350, height: 90)
                    .foregroundColor(.additional_50)
                    .cornerRadius(30)
                    .padding(.top, 24)
                    .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 4)
                
                VStack {
                    HStack {
                        Text(category)
                            .padding(.leading, 40)
                            .foregroundColor(.text_900)
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        //Progress bar
                        ZStack {
                            
                            Circle()
                                .stroke(lineWidth: 8)
                                .foregroundColor(.primary_50)
                                .opacity(0.2)
                                .frame(maxWidth: 60)
                            
                            Circle()
                                .trim(from: 0, to: percentage)
                                .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                                .foregroundColor(.primary_900)
                                .rotation3DEffect(Angle(degrees: 270), axis: (x: 0, y: 0, z: 1))
                                .frame(maxWidth: 60)
                            
                            Text("\(Int(percentage*100))%")
                                .foregroundColor(.text_900)
                                .font(.system(size: 17))
                                .fontWeight(.bold)
                        } .padding(.trailing, 40)
                    } .padding(.top, 20)
                }
            }
        } .navigationTitle(category)
    } 
}

struct ProgressCircleView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircleView(category: "TestCategory", mastered: 3, total: 9)
    }
}
