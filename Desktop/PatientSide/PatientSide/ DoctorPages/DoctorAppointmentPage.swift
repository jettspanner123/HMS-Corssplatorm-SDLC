//
//  DoctorAppointmentPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 27/02/25.
//

import SwiftUI

struct DoctorAppointmentPage: View {
    
    @State var searchText: String = ""
    
    var appointemtnFilter: Array<AppointmentType> = [.all, .upcoming, .completed, .cancelled, .failed]
    
    @State var selectedAppointment: AppointmentType = .all
    
    @State var appointments: Array<Appointment> = [
        .init(appointmentDate: .now.addingTimeInterval(TimeInterval(86400 * 3)), appointmentTime: .now, doctorId: "doctor1", doctorName: "Dr. Uddeshya Singh", patientId: "user1", patientName: "Tushar Sourav", appointmentType: .upcoming),
        .init(appointmentDate: .now.addingTimeInterval(TimeInterval(86400 * 3)), appointmentTime: .now, doctorId: "doctor1", doctorName: "Dr. Uddeshya Singh", patientId: "user1", patientName: "Tushar Sourav", appointmentType: .upcoming),
        .init(appointmentDate: .now.addingTimeInterval(TimeInterval(86400 * 3)), appointmentTime: .now, doctorId: "doctor1", doctorName: "Dr. Uddeshya Singh", patientId: "user1", patientName: "Tushar Sourav", appointmentType: .upcoming),
        .init(appointmentDate: .now, appointmentTime: .now, doctorId: "doctor1", doctorName: "Dr. Uddeshya Singh", patientId: "user1", patientName: "Tushar Sourav", appointmentType: .completed),
    ]
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                SectionHeading(text: "Filters")
                    .padding(.horizontal, 25)
                
                CustomTextField(text: self.$searchText, placeholder: "Search")
                    .overlay {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.black.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                    }
                    .padding(.horizontal, 25)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(self.appointemtnFilter, id: \.self) { appointmentType in
                            Text(appointmentType.rawValue)
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundStyle(self.selectedAppointment == appointmentType ? .white : .black.opacity(0.5))
                                .padding(15)
                                .background(self.selectedAppointment == appointmentType ? .appOrange : .white)
                                .clipShape(Capsule())
                                .shadow(radius: 1)
                                .onTapGesture {
                                    withAnimation {
                                        self.selectedAppointment = appointmentType
                                    }
                                }
                        }
                    }
                    .padding(.horizontal, 25)
                }
                .scrollClipDisabled()
                
                SectionHeading(text: "Appointments")
                    .padding(.top, 20)
                    .padding(.horizontal, 25)
                
                
                if self.appointments.filter({$0.appointmentType == self.selectedAppointment}).isEmpty && self.selectedAppointment != .all {
                    VStack(spacing: 20) {
                        Image(systemName: "note.text")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundStyle(.gray.opacity(0.75))
                        
                        Text("No appointments found.")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundStyle(.gray.opacity(0.75))
                    }
                    .padding(.top, 40)
                }
                
                ForEach(self.$appointments, id: \.appointmentId) { $appointment in
                    if self.selectedAppointment == .all {
                        NavigationLink(destination: AppointmentDetailsPage(appointment: $appointment)) {
                            AppointmentCard(appointment: $appointment)
                                .padding(.horizontal, 25)
                        }
                        .transition(.offset(y: UIScreen.main.bounds.height))
                    } else {
                        
                        
                        
                        if self.selectedAppointment == appointment.appointmentType {
                            NavigationLink(destination: AppointmentDetailsPage(appointment: $appointment)) {
                                AppointmentCard(appointment: $appointment)
                                    .padding(.horizontal, 25)
                            }
                            .transition(.offset(y: UIScreen.main.bounds.height))
                        }
                    }
                }
                
                
            
            }
            .padding(.vertical, 100)
        }
    }
}

#Preview {
    DoctorAppointmentPage()
}
