//
//  DoctorDetailsPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 21/02/25.
//

import SwiftUI

struct DoctorDetailsPage: View {
    
    var doctor: Doctor
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
            SecondaryPageHeader(headingText: "Details")
                .offset(y: 25)
                .zIndex(12)
            
            ScrollView {
                VStack {
                    
                }
            }
        }
        .background(.gray.opacity(0.3))
        .navigationBarBackButtonHidden()
    }
}

