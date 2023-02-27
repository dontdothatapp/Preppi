//
//  PremiumLine.swift
//  Preppi
//
//  Created by Степан Величко on 24.02.2023.
//

import SwiftUI

struct PremiumLine: View {
    
    @State var caption: String
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark")
                .foregroundColor(.primary_500)
            Text(caption)
                .foregroundColor(.text_700)
                .font(.system(size: 16))
                .fontWeight(.regular)
                .padding(.leading, 10)
        }
    }
}

struct PremiumLine_Previews: PreviewProvider {
    static var previews: some View {
        PremiumLine(caption: "Unlimited saved")
    }
}
