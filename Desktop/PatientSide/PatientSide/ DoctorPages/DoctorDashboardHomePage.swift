//
//  DoctorDashboardHomePage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 27/02/25.
//

import SwiftUI

struct DoctorDashboardHomePage: View {
    
    @Binding var doctor: Doctor
    
    
    @EnvironmentObject var appStates: AppStates
    
    var body: some View {
        ZStack {
            VStack {
                SectionHeading(text: "Appointments Today")
                    .padding(.horizontal, 25)
                
                // MARK: Appointment Information
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        
                        
                        // MARK: Today's appointment
                        DoctorInformationCard(iconsName: "person.fill", title: "Appointments", color: .appOrange, textColor: .white, bottomText: "Today's Appointment", number: String(self.appStates.appointments.count))
                        
                        let pendingCount = self.appStates.appointments.filter({$0.appointmentType == .upcoming}).count
                        let completedCount = self.appStates.appointments.filter({$0.appointmentType == .completed}).count
                        let failedCount = self.appStates.appointments.filter({$0.appointmentType == .failed}).count
                        
                        // MARK: Pending Appointments
                        if pendingCount > 0 {
                            DoctorInformationCard(iconsName: "person.fill", title: "Something", color: .white, textColor: .appOrange, bottomText: "Pending Appointment", number: String(pendingCount))
                        }
                        
                        // MARK: Complete Appointments
                        if completedCount > 0 {
                            DoctorInformationCard(iconsName: "person.fill", title: "Something", color: .white, textColor: .appOrange, bottomText: "Complete Appointment", number: String(completedCount))
                        }
                        
                        // MARK: Failed Appointment
                        if failedCount > 0 {
                            DoctorInformationCard(iconsName: "person.fill", title: "Something", color: .white, textColor: .appOrange, bottomText: "Failed     Appointment", number: String(failedCount))
                        }
                        
                    }
                    .padding(.horizontal, 25)
                }
                .scrollClipDisabled()
                
                SectionHeading(text: "Emergency Cases")
                    .padding(.top, 20)
                    .padding(.horizontal, 25)
                
                ForEach(self.$appStates.emergency, id: \.emergencyId) { $emergency in
                    EmergencyCard(emergency: $emergency)
                        .padding(.horizontal, 25)
                }
                
                
                SectionHeading(text: "Quick Actions")
                    .padding(.horizontal, 25)
                    .padding(.top, 20)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                    
                    NavigationLink(destination: DoctorCrisisPage()) {
                        QuickActionCards(iconName: "exclamationmark.triangle.fill", color: .emergency, textColor: .white, title: "Crisis")
                    }
                    NavigationLink(destination: ApplyLeavePage(doctor: self.$doctor)) {
                        QuickActionCards(iconName: "paperplane.fill", color: .white, textColor: .appOrange, title: "Leave")
                    }
                    NavigationLink(destination: DoctorSchedulePage(doctor: self.$doctor)) {
                        QuickActionCards(iconName: "calendar", color: .white, textColor: .appOrange, title: "Agenda")
                    }
                    
                    
                }
                .padding(.horizontal, 25)
                
                SectionHeading(text: "Appointments Overview")
                    .padding(.top, 20)
                    .padding(.horizontal, 25)
                
                DoctorShowAppointmentsCard(doctor: self.$doctor, id: "upcoming", color: .gray, textColor: .white)
                    .padding(.horizontal, 25)
                
                DoctorShowAppointmentsCard(doctor: self.$doctor, id: "completed", color: .appGreen, textColor: .white)
                    .padding(.horizontal, 25)
                
            }
            .padding(.vertical, 100)
        }
    }
}

#Preview {
    
    @Previewable @State var doctor: Doctor = .init(doctorId: "doctor1", hospitalName: "Neelam", fullName: "Uddeshya SIngh", username: "doc#jettspanner123", password: "Saahil123s", height: 198, weight: 98, bloodGroup: .abn, doctorName: "Dr. Uddeshya Singh", hospitalId: "hospital1", speciality: "Gayology", medicalAcomplishment: "MBBS")
    DoctorDashboardHomePage(doctor: $doctor)
}
