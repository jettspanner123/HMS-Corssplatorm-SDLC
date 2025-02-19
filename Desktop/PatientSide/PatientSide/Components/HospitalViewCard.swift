//
//  HospitalViewCard.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 18/02/25.
//

import SwiftUI
struct HospitalViewCard: View {
    
    var hospital: Hospital
    @Binding var selectedHospital: String
   
    var body: some View {
        HStack(spacing: 10) {
            
            // MARK: Image stack
            HStack {
                
            }
            .frame(height: 100)
            .frame(maxWidth: UIScreen.main.bounds.width * 0.5  - 50)
            .background(.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
            
            // MARK: Information stack
            VStack(alignment: .leading, spacing: 2) {
                
                Text(self.hospital.hospitalName)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(self.selectedHospital == self.hospital.hospitalId ? .white : .black.opacity(0.5))

                Text(self.hospital.location)
                    .font(.system(size: 10, weight: .regular, design: .rounded))
                    .foregroundStyle(self.selectedHospital == self.hospital.hospitalId ? .white : .black.opacity(0.5))
                
                
                Spacer()
                
                Text(self.hospital.hospitalId)
                    .font(.system(size: 10, weight: .regular, design: .rounded))
                    .foregroundStyle(self.selectedHospital == self.hospital.hospitalId ? .white : .black.opacity(0.5))

            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.vertical, 10)
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(15)
        .background(self.selectedHospital == self.hospital.hospitalId ? .appOrange : .white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 1)
        
    }
}
