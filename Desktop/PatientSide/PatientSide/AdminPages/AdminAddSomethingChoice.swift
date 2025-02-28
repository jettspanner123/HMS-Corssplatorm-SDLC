//
//  AdminAddSomethingChoice.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 27/02/25.
//

import SwiftUI

struct AdminAddSomethingChoice: View {
    var image: String
    var heading: String
    
    var body: some View {
        HStack {
            Image(systemName: self.image)
                .foregroundStyle(.appOrange.gradient)
            
            Text(self.heading)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundStyle(.black.opacity(0.5))
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.black.opacity(0.5))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 55)
        .padding(.horizontal, 25)
        .background(.white.gradient)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 1)
    }
}
