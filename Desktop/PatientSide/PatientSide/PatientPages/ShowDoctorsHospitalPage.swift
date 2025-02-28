//
//  ShowDoctorsHospitalPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 28/02/25.
//

import SwiftUI

struct ShowDoctorsHospitalPage: View {
    
    @Binding var hospital: Hospital
    @Binding var patient: SendUser
    
    @State var hospitalDoctors: Array<Doctor> = []
    
    @EnvironmentObject var appStates: AppStates
    
    func fetchDoctors() -> Void {
        for doctor in self.appStates.doctors {
            if doctor.hospitalId == self.hospital.hospitalId {
                self.hospitalDoctors.append(doctor)
            }
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
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
                SecondaryPageHeader(headingText: "Hospital")
                    .offset(y: 25)
                    .zIndex(12)
                
                
                
                ScrollView {
                    VStack {
                        SectionHeading(text: "Hospital Doctors")
                        
                        ForEach(self.$hospitalDoctors, id: \.doctorId) { $doctor in
                            NavigationLink(destination: BookAppointmentPage(doctor: $doctor, patient: self.$patient)) {
                                DoctorCard(doctor: doctor)
                            }
                        }
                    }
                    .padding(.top, 110)
                    .padding(.horizontal, 25)
                }
                
            }
            .background(.gray.opacity(0.2))
            .navigationBarBackButtonHidden()
            .onAppear {
                self.fetchDoctors()
            }
            
        }
    }
    
}

