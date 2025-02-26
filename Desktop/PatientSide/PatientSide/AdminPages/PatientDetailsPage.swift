//
//  PatientDetailsPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 26/02/25.
//

import SwiftUI

struct PatientDetailsPage: View {
    
    @Binding var patient: SendUser
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
            SecondaryPageHeader(headingText: "Details", id: .doctorDetails)
                .offset(y: 25)
                .zIndex(12)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    SectionHeading(text: "Personal Details")
                    
                    VStack {
                        SpaceBetweenTextView(firstText: "Full Name", secondText: self.patient.fullName)
                        CustomDivider()
                        
                        
                        SpaceBetweenTextView(firstText: "Height", secondText: "\(self.patient.height)")
                        CustomDivider()
                        
                        SpaceBetweenTextView(firstText: "Weight", secondText: "\(self.patient.weight)")
                        CustomDivider()
                        
                        SpaceBetweenTextView(firstText: "Email", secondText: self.patient.email)
                        CustomDivider()
                        
                        SpaceBetweenTextView(firstText: "Phone Number", secondText: self.patient.phoneNumber)
                        CustomDivider()
                        
                        SpaceBetweenTextView(firstText: "Blood Group", secondText: self.patient.bloodGroup.rawValue)
                        CustomDivider()
                        
                        SpaceBetweenTextView(firstText: "Location", secondText: self.patient.location)
                        CustomDivider()
                        
                        SpaceBetweenTextView(firstText: "Identification", secondText: self.patient.id)

                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(15)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                }
                .padding(.horizontal, 25)
                .padding(.top, 110)
                .padding(.bottom, 40)
            }
        }
        .background(.gray.opacity(0.2))
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    
    @Previewable @State var patient: SendUser = .init(id: "user1", fullName: "Tushar Sourav", email: "tushar@gmail.com", location: "Patiala, Punajb", phoneNumber: "9875660105", userType: "", height: 183, weight: 89, bloodGroup: .abn)
    PatientDetailsPage(patient: $patient)
}
