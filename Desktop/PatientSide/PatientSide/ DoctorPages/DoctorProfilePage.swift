//
//  DoctorProfilePage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 27/02/25.
//

import SwiftUI

struct DoctorProfile: View {
    
    @Binding var showProfilePage: Bool
    @State var showEditPage: Bool = false
    @Binding var doctor: Doctor
    
    @State var patients: Array<SendUser> = []
    @State var appointments: Array<Appointment> = []
    
    @EnvironmentObject var appStates: AppStates
    
    func fetchPatients() {
        
        var temp: Array<String> = []
        
        for appointment in self.appStates.appointments {
            if appointment.doctorId == self.doctor.doctorId {
                self.appointments.append(appointment)
                temp.append(appointment.patientId)
            }
        }
        
        for patientId in temp {
            for patient in self.appStates.users {
                if patient.id == patientId {
                    self.patients.append(patient)
                }
            }
        }
        
    }
    
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
                ProfilePageHeader(headingText: "Profile", onClick: {
                    withAnimation {
                        self.showProfilePage = false
                    }
                }) {
                    self.showEditPage = true
                }
                .offset(y: 25)
                .zIndex(12)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        SectionHeading(text: "Public Profile")
                        
                        
                        // MARK: Doctor profile card
                        HStack(spacing: 15) {
                            
                            
                            // MARK: Name initals card
                            HStack {
                                Text(String(getInitials(name: self.doctor.doctorName).suffix(2)))
                                    .font(.system(size: 30, weight: .black, design: .monospaced))
                                    .foregroundStyle(.white.gradient)
                            }
                            .frame(width: 100, height: 100)
                            .background(.appOrange.gradient)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                            
                            // MARK: Name and specialisation
                            VStack {
                                Text(self.doctor.doctorName)
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundStyle(.black.opacity(0.75))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text(self.doctor.speciality)
                                    .font(.system(size: 12, weight: .regular, design: .rounded))
                                    .foregroundStyle(.black.opacity(0.5))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding(.vertical, 10)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(15)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                        
                        // MARK: All other information
                        
                        SectionHeading(text: "Other Informations")
                            .padding(.top, 20)
                        
                        VStack {
                            SpaceBetweenTextView(firstText: "Height", secondText: String(self.doctor.height))
                            CustomDivider()
                            
                            SpaceBetweenTextView(firstText: "Weight", secondText: String(self.doctor.weight))
                            CustomDivider()
                            
                            SpaceBetweenTextView(firstText: "Doctor's Id", secondText: self.doctor.doctorId)
                            CustomDivider()
                            
                            SpaceBetweenTextView(firstText: "Hospital Name", secondText: self.doctor.hospitalName)
                            CustomDivider()
                            
                            SpaceBetweenTextView(firstText: "Hospital Id", secondText: self.doctor.hospitalId)
                            CustomDivider()
                            
                            SpaceBetweenTextView(firstText: "Username", secondText: self.doctor.username)
                            CustomDivider()
                            
                            SpaceBetweenTextView(firstText: "Blood Group", secondText: self.doctor.bloodGroup.rawValue)
                            CustomDivider()
                            
                            SpaceBetweenTextView(firstText: "Medical Acomplishment", secondText: self.doctor.medicalAcomplishment)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(15)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                        
                        
                        SectionHeading(text: "Patient History")
                            .padding(.top, 20)
                        
                        ForEach(self.$patients, id: \.id) { $patient in
                            NavigationLink(destination: PatientDetailsPage(patient: $patient)) {
                                PatientCard(patient: $patient)
                            }
                        }
                        
                        SectionHeading(text: "Appointment History")
                            .padding(.top, 20)
                        
                        ForEach(self.$appointments, id: \.appointmentId) { $appointment in
                            NavigationLink(destination: AppointmentDetailsPage(appointment: $appointment)) {
                                AppointmentCard(appointment: $appointment)
                            }
                        }
                    }
                    .padding(.top, 110)
                    .padding(.horizontal, 25)
                    .padding(.bottom, 40)
                }
            }
            .background(.appBackground)
            .navigationDestination(isPresented: self.$showEditPage) {
                DoctorProfileEditPage(doctor: self.$doctor)
            }
            .onAppear {
                self.fetchPatients()
            }
        }
    }
}

