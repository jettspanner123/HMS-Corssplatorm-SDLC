//
//  EmergencyCard.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 28/02/25.
//

import SwiftUI

struct EmergencyCard: View  {
    
    @Binding var emergency: Emergency
    var body: some View {
        VStack {
            HStack {
                
                // MARK: Image backdrop
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(.white)
                }
                .padding(8)
                .background(.white.opacity(0.1))
                .clipShape(Circle())
                
                Text("Emergency")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                
                Spacer()
                
                Text("#" + String(self.emergency.emergencyId.prefix(10)))
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Text(self.emergency.patientDiagnosys)
                .font(.system(size: 13, weight: .regular, design: .rounded))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 100, alignment: .topLeading)
        .padding(15)
        .background(.appRed.gradient)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 1)
    }
}

