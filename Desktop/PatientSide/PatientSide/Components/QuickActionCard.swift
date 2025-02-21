//
//  QuickActionCard.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 21/02/25.
//

import SwiftUI
struct QuickActionCards: View {
    
    var iconName: String
    var color: Color
    var textColor: Color
    var title: String
    
    var body: some View {
        HStack {
            
            HStack {
                
                Image(systemName: self.iconName)
                    .resizable()
                    .frame(width: 13, height: 13)
                    .foregroundStyle(self.textColor)
            }
            .padding(8)
            .background(self.textColor.opacity(0.25))
            .clipShape(Circle())
            
            
            Spacer()
            Text(self.title)
                .foregroundStyle(self.textColor.gradient)
            
            Image(systemName: "chevron.right")
                .scaleEffect(0.9)
                .foregroundStyle(self.textColor)
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 70)
        .padding(.horizontal, 20)
        .background(self.color.gradient)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 1)
    }
}

