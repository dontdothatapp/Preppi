//
//  StatsCardView.swift
//  Preppi
//
//  Created by Степан Величко on 11.02.2023.
//

import SwiftUI

struct StatsCardView: View {
    
    //@Binding var progress: Float
    @State var progressValue: Int
    @State var category: String
    //@Binding var percentage: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 350, height: 90)
                .foregroundColor(.additional_50)
                .cornerRadius(30)
                .padding(.top, 24)
                .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 4)
            
            VStack {
                HStack{
                    Text(category)
                        .padding(.leading, 40)
                        .foregroundColor(.text_900)
                        .font(.system(size: 17))
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    ZStack {
                        ProgressBarView(progress: Float(progressValue))
                            .frame(width: 56).onAppear() {
                                Float(progressValue)
                            }
//                        Text("\(percentage)%")
//                            .foregroundColor(.text_900)
//                            .font(.system(size: 17))
//                            .fontWeight(.bold)
                    }
                    .padding(.trailing, 40)
                }
                .padding(.top, 16)
            }
        } .frame(height: 90)
    }
}

//struct StatsCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatsCardView(progress: 0.0, progressValueBehavioral: 0.72)
//    }
//}
