//
//  AdminDashboardPatientPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 27/02/25.
//

import SwiftUI

struct AdminDashboardPatientPage: View {
    var body: some View {
        ZStack {
            VStack {
                
                SectionHeading(text: "Quick Statistics")
            }
            .padding(.vertical, 100)
            .padding(.horizontal, 25)
        }
    }
}

#Preview {
    AdminDashboardPatientPage()
}
