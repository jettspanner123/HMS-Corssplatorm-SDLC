//
//  AdminDashboardPatientPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 27/02/25.
//

import SwiftUI

struct AdminDashboardPatientPage: View {
    
    @State var activeSelectedHospital: Bool = true
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Active Hospitals")
                        .font(.system(size: 15, weight: .regular, design: .default))
//                        .foregroundStyle(self.activeSelectedHospital ? )
                        .padding(15)
                        .background(self.activeSelectedHospital ? .appOrange : .white)
                        .clipShape(Capsule())
                        .shadow(radius: 1)
                    
                    Text("Active Hospitals")
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .padding(15)
                        .background(self.activeSelectedHospital ? .appOrange : .white)
                        .clipShape(Capsule())
                        .shadow(radius: 1)
                }
            }
            .padding(.vertical, 100)
            .padding(.horizontal, 25)
        }
    }
}

#Preview {
    AdminDashboardPatientPage()
}
