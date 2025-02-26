//
//  AppointmentDetails.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 26/02/25.
//

import SwiftUI

struct AppointmentDetailsPage: View {
    
    @Binding var appointment: Appointment
    
    @EnvironmentObject var appStates: AppStates
    
    @State var theDoctor: Doctor = .init(doctorId: "doctor1", hospitalName: "Neelam Hospital", fullName: "Uddeshay Singh", username: "doc#jettspanner123", password: "Saahil123s", height: 189, weight: 89, bloodGroup: .abn, doctorName: "Dr. Uddeshya Singh", hospitalId: "hos123", speciality: "Gyno", medicalAcomplishment: "MBBS")
    @State var thePatient: SendUser = .init(id: "", fullName: "Uddeshya Singh", email: "", location: "", phoneNumber: "", userType: "")
    
    func getDoctorAndPatient() -> Void {
        for doctor in self.appStates.doctors {
            if doctor.doctorId == self.appointment.doctorId {
                self.theDoctor = doctor
            }
        }
        
        for patient in self.appStates.users {
            if patient.id == self.appointment.patientId {
                self.thePatient = patient
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
                SecondaryPageHeader(headingText: "Details")
                    .offset(y: 25)
                    .zIndex(12)
                
                
                
                // MARK: Content View
                ScrollView {
                    VStack {
                        
                        
                        SectionHeading(text: "Appointment Details")
                        
                        VStack {
                            
                            SpaceBetweenTextView(firstText: "Doctor Name", secondText: self.appointment.doctorName)
                            CustomDivider()
                            
                            SpaceBetweenTextView(firstText: "Patient Name", secondText: self.appointment.patientName)
                            CustomDivider()
                            
                            SpaceBetweenTextView(firstText: "Date", secondText: getHumanRedableDate(from: self.appointment.appointmentDate))
                            CustomDivider()
                            
                            SpaceBetweenTextView(firstText: "Time", secondText: getTime(from: self.appointment.appointmentTime))
                            CustomDivider()
                            
                            SpaceBetweenTextView(firstText: "Status", secondText: self.appointment.appointmentType.rawValue)
                            
                        }
                        .frame(maxWidth: .infinity)
                        .padding(15)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                        
                        SectionHeading(text: "Doctor")
                            .padding(.top, 20)
                        
                        NavigationLink(destination: DoctorDetailsPage(doctor: self.theDoctor)) {
                            DoctorCard(doctor: self.theDoctor)
                        }
                        
                        
                        SectionHeading(text: "Patient")
                            .padding(.top, 20)
                        
                        NavigationLink(destination: PatientDetailsPage(patient: self.$thePatient)) {
                            PatientCard(patient: self.$thePatient)
                        }
                        
                        
                    }
                    .padding(.top, 110)
                    .padding(.horizontal, 25)
                }
                
            }
            .background(.gray.opacity(0.2))
            .navigationBarBackButtonHidden()
            .onAppear{
                self.getDoctorAndPatient()
            }
        }
    }
}


struct PatientCard: View {
    
    @Binding var patient: SendUser
    
    var body: some View {
        HStack {
            
            HStack {
                Text(getInitials(name: self.patient.fullName))
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: 60, maxHeight: 60)
            .background(.appOrange.gradient)
            .clipShape(Circle())
            .shadow(radius: 1)
            
            
            VStack {
                Text(self.patient.fullName)
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundStyle(.black.opacity(0.5))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(self.patient.bloodGroup.rawValue)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundStyle(.black.opacity(0.5))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.vertical, 10)
            
            Spacer()
            
            // MARK: Navigation arrow
            HStack(alignment: .top) {
                Image(systemName: "arrow.right")
                    .foregroundStyle(.secondaryAccent)
            }
            .frame(maxHeight: .infinity)
            .padding(.trailing, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: 100, alignment: .leading)
        .padding(10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 1)
    }
}
//#Preview {
    //
    //    @Previewable @State var thePatient: SendUser = .init(id: "", fullName: "Uddeshya Singh", email: "", location: "", phoneNumber: "", userType: "")
    //    VStack {
    //        PatientCard(patient: $thePatient)
    //    }
    //    .frame(maxWidth: .infinity, maxHeight: .infinity)
    //    .background(.gray.opacity(0.2))
    
    //    @Previewable @EnvironmentObject var appStates: AppStates
    
//    @Previewable @State var appointment = Appointment(
//        appointmentDate: Date().addingTimeInterval(86400 * 4), // 2 days from now
//        appointmentTime: Date().addingTimeInterval(2 * 24 * 60 * 60 + 8 * 60 * 60), // 2 days + 8 hours
//        doctorId: "doctor1",
//        doctorName: "Dr. Uddeshya Singh",
//        patientId: "user1",
//        patientName: "Tushar Saurav",
//        appointmentType: .upcoming
//    )
//    
//    
//    
//    AppointmentDetailsPage(appointment: $appointment)
//    //        .environmentObject(appStates)
//}
//
