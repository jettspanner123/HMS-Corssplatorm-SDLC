//
//  AppointmentCard.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 26/02/25.
//

import SwiftUI


struct AppointmentCard: View {
    
    @Binding var appointment: Appointment
    
    var wantArrow: Bool = true
    
    var body: some View {
        VStack {
            
            HStack {
                VStack(alignment: .leading) {
                    Text(self.appointment.doctorName)
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(.black)
                    
                    Text("for \(self.appointment.patientName)")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.gray.opacity(0.75))
                }
                
                
                Spacer()
                
                let dateDistance = abs(daysBetween(from: .now, to: self.appointment.appointmentDate))
                if self.appointment.appointmentType == .cancelled || self.appointment.appointmentType == .failed {
                    Text(String(dateDistance)  + " day" + (dateDistance == 1 ? "" : "s"))
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: 65)
                        .padding(5)
                        .background(.appRed.gradient)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(radius: 1)
                    
                } else if self.appointment.appointmentType == .completed {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: 65)
                        .padding(5)
                        .background(.appGreen.gradient)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(radius: 1)
                    
                } else {
                    if dateDistance > 2 {
                        Text(String(dateDistance)  + " day" + (dateDistance == 1 ? "" : "s"))
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundStyle(.white)
                            .frame(maxWidth: 65)
                            .padding(5)
                            .background(.appGreen.gradient)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(radius: 1)
                        
                    } else if dateDistance > 1 {
                        Text(String(dateDistance)  + " day" + (dateDistance == 1 ? "" : "s"))
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundStyle(.white)
                            .frame(maxWidth: 65)
                            .padding(5)
                            .background(.appYellow.gradient)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(radius: 1)
                        
                    } else {
                        Text(String(dateDistance)  + " day" + (dateDistance == 1 ? "" : "s"))
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundStyle(.white)
                            .frame(maxWidth: 65)
                            .padding(5)
                            .background(.appRed.gradient)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(radius: 1)
                        
                    }
                    
                    
                    
                }
                
                if self.wantArrow {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.black.opacity(0.5))
                }
            }
            .frame(maxWidth: .infinity)
            
            
            HStack {
                
                HStack {
                    Image(systemName: "calendar")
                        .foregroundStyle(.black.opacity(0.75))
                    
                    Text(getHumanRedableDate(from: self.appointment.appointmentDate))
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                }
                .padding(5)
                .background(.appBackground.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 5))
                
                HStack {
                    Image(systemName: "calendar")
                        .foregroundStyle(.black.opacity(0.75))
                    
                    Text(getTime(from: self.appointment.appointmentTime))
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                }
                .padding(5)
                .background(.appBackground.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 15)
            
            
        }
        .frame(maxWidth: .infinity)
        .padding(15)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 1)
    }
}

