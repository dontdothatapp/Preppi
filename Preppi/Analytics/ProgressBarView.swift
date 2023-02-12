//
//  ProgressBarView.swift
//  Preppi
//
//  Created by Степан Величко on 28.01.2023.
//

import SwiftUI

struct ProgressBarView: View {
    
    @Binding var progress: Float
    
    var color: Color = Color.primary_900
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 9.0)
                .opacity(0.2)
                .foregroundColor(Color.primary_50)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 2.0))
        }
    }
}
