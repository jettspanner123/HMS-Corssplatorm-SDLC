//
//  AddHospitalCard.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 18/02/25.
//

import SwiftUI

struct AddHospitalCard: View {
    var body: some View {
        HStack {
            
            // MARK: Add icon frame
            Image(systemName: "plus.circle.fill")
                .foregroundStyle(.appOrange)
            
            
            
            // MARK: Add Hospital Page
            Text("Add Hospital")
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundStyle(.appOrange)
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 55)
        .background(.white.gradient)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 1)
    }
}

