//
//  DoctorShowAppointmentsCard.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 28/02/25.
//

import SwiftUI

struct DoctorShowAppointmentsCard: View {
    @Binding var doctor: Doctor
    
    var id: String = ""
    var color: Color
    var textColor: Color
    
    @EnvironmentObject var appStates: AppStates
    
    @State var appointments = AppStates().appointments
    
    //    @State var appointments: Array<Appointment> = [
    //        .init(appointmentDate: .now.addingTimeInterval(TimeInterval(86400 * 3)), appointmentTime: .now, doctorId: "doctor1", doctorName: "Dr. Uddeshya Singh", patientId: "user1", patientName: "Tushar Sourav", appointmentType: .upcoming),
    //        .init(appointmentDate: .now.addingTimeInterval(TimeInterval(86400 * 3)), appointmentTime: .now, doctorId: "doctor1", doctorName: "Dr. Uddeshya Singh", patientId: "user1", patientName: "Tushar Sourav", appointmentType: .upcoming),
    //        .init(appointmentDate: .now.addingTimeInterval(TimeInterval(86400 * 3)), appointmentTime: .now, doctorId: "doctor1", doctorName: "Dr. Uddeshya Singh", patientId: "user1", patientName: "Tushar Sourav", appointmentType: .upcoming),
    //        .init(appointmentDate: .now, appointmentTime: .now, doctorId: "doctor1", doctorName: "Dr. Uddeshya Singh", patientId: "user1", patientName: "Tushar Sourav", appointmentType: .completed),
    //    ]
    
    func getAppointments() -> Void {
        
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                // MARK: Heading
                HStack {
                    HStack {
                        if self.id == "upcoming" {
                            Image(systemName: "calendar")
                                .foregroundStyle(self.color.gradient)
                        } else if self.id == "completed" {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundStyle(self.color.gradient)
                        }
                    }
                    .frame(width: 50, height: 50)
                    .background(self.color.opacity(0.25).gradient)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .fill(.clear)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .shadow(radius: 1)
                    }
                    
                    VStack {
                        Text(self.id.capitalized)
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(self.id == "upcoming" ? "Next for appointments" : "")
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.gray.opacity(0.75))
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    Spacer()
                    
                    Text(self.id == "upcoming" ? String(self.appointments.filter({ $0.appointmentType == .upcoming }).count) : String(self.appointments.filter({ $0.appointmentType == .completed }).count))
                        .font(.system(size: 25, weight: .black, design: .monospaced))
                        .foregroundStyle(self.color)
                        .padding(.horizontal, 20)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                if self.id == "upcoming" {
                    ForEach(self.appointments.indices, id: \.self)  { index in
                        if self.appointments[index].appointmentType == .upcoming {
                            NavigationLink(destination: AppointmentDetailsPage(appointment: self.$appointments[index])) {
                                InformationListItem(key: self.appointments[index].patientName, value: getTime(from: self.appointments[index].appointmentTime))
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 5)
                                    .onTapGesture {
                                        print("Clicked")
                                    }
                                
                            }
                            
                            if index < self.appointments.filter({ $0.appointmentType == .upcoming}).count - 1 {
                                CustomDivider()
                            }
                        }
                    }
                } else if self.id == "completed" {
                    ForEach(self.appointments.indices, id: \.self)  { index in
                        if self.appointments[index].appointmentType == .completed {
                            NavigationLink(destination: AppointmentDetailsPage(appointment: self.$appointments[index])) {
                                InformationListItem(key: self.appointments[index].patientName, value: getTime(from: self.appointments[index].appointmentTime))
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 5)
                                    .onTapGesture {
                                        print("Clicked")
                                    }
                            }
                            
                            if index < self.appointments.filter({ $0.appointmentType == .completed }).count - 1 {
                                CustomDivider()
                            }
                        }
                    }
                }
                
            }
            .frame(maxWidth: .infinity)
            .padding(15)
            .background(.white.gradient)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(radius: 1)
        }
    }
}

