//
//  AdminDashboardInformationCard.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 20/02/25.
//

import SwiftUI

struct InformationCard:  View {
    
    var iconsName: String
    var title: String
    var color: Color
    var textColor: Color
    var infoText: Int
    
    var body: some View {
        VStack(spacing: 5) {
            
            HStack {
                HStack {
                    Image(systemName: self.iconsName)
                        .resizable()
                        .frame(width: 13 , height: 13)
                        .foregroundStyle(self.textColor)
                    
                }
                .padding(10)
                .background(self.textColor.opacity(0.14))
                .clipShape(Circle())
                
                Spacer()
                
                Text("+3.25%")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundStyle(self.textColor)
                
                Image(systemName: "chevron.right")
                    .scaleEffect(0.9)
                    .foregroundStyle(self.textColor)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 0) {
               
                Text("\(String(self.infoText))")
                    .font(.system(size: 45, weight: .bold, design: .rounded))
                    .foregroundStyle(self.textColor)
                
                Text(self.title)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .foregroundStyle(self.textColor)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .frame(maxWidth: .infinity, maxHeight: 125, alignment: .top)
        .padding(20)
        .background(self.color.gradient)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 2)
        
    }
}

