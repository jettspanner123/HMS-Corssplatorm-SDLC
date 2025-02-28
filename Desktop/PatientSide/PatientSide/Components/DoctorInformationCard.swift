//
//  DoctorInformationCard.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 27/02/25.
//

import SwiftUI

struct DoctorInformationCard: View {
    var iconsName: String
    var title: String
    var color: Color
    var textColor: Color
    var bottomText: String = ""
    var number: String
    
    var body: some View {
        VStack(spacing: 5) {
            
            Text(self.number)
                .font(.system(size: 55, weight: .black, design: .monospaced))
                .foregroundStyle(self.textColor.gradient)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            
            Text(self.bottomText)
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .multilineTextAlignment(.leading)
                .foregroundStyle(self.textColor.opacity(0.75))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: 120, height: 100, alignment: .topLeading)
        .padding(20)
        .background(self.color.gradient)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 2)
    }
}
