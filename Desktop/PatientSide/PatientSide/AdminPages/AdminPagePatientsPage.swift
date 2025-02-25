//
//  AdminPagePatientsPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 19/02/25.
//

import SwiftUI

struct AdminPagePatientsPage: View {
    var body: some View {
        ZStack(alignment: .top) {
            
            
            
            // MARK: Top background blur for header
            HStack {
                
            }
            .frame(maxWidth: .infinity, maxHeight: 140)
            .background(AppBackgroundBlur(radius: 15))
            .ignoresSafeArea()
            .offset(y: -15)
            .zIndex(11)
            
            // MARK: Page heading
            SecondaryPageHeader(headingText: "Details", id: "patientPage")
            .offset(y: 25)
            .zIndex(12)
            
            ScrollView {
                VStack {
                    SectionHeading(text: "Filters")
                }
                .padding(.top, 110)
                .padding(.horizontal, 25)
            }
        }
        .background(.gray.opacity(0.2))
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    AdminPagePatientsPage()
}
