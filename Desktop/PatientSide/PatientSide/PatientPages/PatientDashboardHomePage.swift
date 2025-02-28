//
//  PatientDashboardHomePage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 28/02/25.
//

import SwiftUI

struct PatientDashboardHomePage: View {
    
    @Binding var user: SendUser
    
    @State var selectedAppointmentFilter: AppointmentType = .all
    
    var appointmentTabs: Array<AppointmentType> = [
        .all, .upcoming, .completed, .failed, .cancelled
    ]
    
    @EnvironmentObject var appStates: AppStates
    
    
    var body: some View {
        ZStack {
            VStack {
                SectionHeading(text: "Filters")
                    .padding(.horizontal, 25)
                
                // MARK: Appointments filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(self.appointmentTabs, id: \.self) { appointmentType in
                            if self.selectedAppointmentFilter == appointmentType {
                                Text(appointmentType.rawValue)
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundStyle(.white)
                                    .padding(15)
                                    .background(.appOrange.gradient)
                                    .clipShape(Capsule())
                                    .shadow(radius: 1)
                                    .onTapGesture {
                                        withAnimation {
                                            self.selectedAppointmentFilter = appointmentType
                                        }
                                    }
                            } else {
                                Text(appointmentType.rawValue)
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundStyle(.black.opacity(0.5))
                                    .padding(15)
                                    .background(.white.gradient)
                                    .clipShape(Capsule())
                                    .shadow(radius: 1)
                                    .onTapGesture {
                                        withAnimation {
                                            self.selectedAppointmentFilter = appointmentType
                                        }
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
                
                if self.appStates.appointments.filter({ $0.appointmentType == self.selectedAppointmentFilter}).isEmpty && self.selectedAppointmentFilter != .all {
                    VStack(spacing: 20) {
                        Image(systemName: "note.text")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundStyle(.gray.opacity(0.75))
                        
                        Text("No appointment found.")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundStyle(.gray.opacity(0.75))
                    }
                    .padding(.top, 40)
                }
                
                ForEach(self.$appStates.appointments, id: \.appointmentId) { $appointment in
                    if self.selectedAppointmentFilter == .all && self.user.id == appointment.patientId{
                        AppointmentCard(appointment: $appointment, wantArrow: false)
                            .transition(.offset(y: UIScreen.main.bounds.height))
                            .padding(.horizontal, 25)
                    } else {
                        if self.selectedAppointmentFilter == appointment.appointmentType && self.user.id == appointment.patientId {
                            AppointmentCard(appointment: $appointment, wantArrow: false)
                                .transition(.offset(y: UIScreen.main.bounds.height))
                                .padding(.horizontal, 25)
                        }
                    }
                    
                }
                
                SectionHeading(text: "Events & Campeigns")
                    .padding(.top, 20)
                    .padding(.horizontal, 25)
                
                // MARK: Event horizontal scroll
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(self.$appStates.events, id: \.eventId) { $event in
                            EventCard(event: $event)
                                .frame(width: 275, height: 175, alignment: .topLeading)
                        }
                    }
                    .padding(.horizontal, 25)
                }
                .scrollClipDisabled()
                
                
                
                
            }
            .padding(.vertical, 100)
        }
    }
}

#Preview {
    PatientDashboardHomePage(user: .constant(.init(id: "user1", fullName: "Uddeshya Singh", email: "uddeshya@gmail.com", location: "Patiala, Punjab", phoneNumber: "9875660105", userType: "user")))
}
