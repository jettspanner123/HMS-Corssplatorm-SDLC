//
//  DoctorAditionlPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 28/02/25.
//

import SwiftUI

struct DoctorAditionlPage: View {
    
    @Binding var doctor: Doctor
    
    @State var leaves: Array<Leave> = [
        .init(fromDoctorid: "doctor1",  fromDoctorName: "Dr. Uddeshya Singh",leaveDescription: "Need leave because of being sick to the core.", leaveStatus: .pending, from: .now, to: .now.addingTimeInterval(TimeInterval(86400 * 2))),
        .init(fromDoctorid: "doctor2",  fromDoctorName: "Dr. Tanishq Biryani",leaveDescription: "Ghar ja rela hai apun, kyuki babuji ki zami batreli hai.", leaveStatus: .approved, from: .now, to: .now.addingTimeInterval(TimeInterval(86400 * 2))),
        .init(fromDoctorid: "doctor3",  fromDoctorName: "Dr. Vanshika Garg",leaveDescription: "Had too much lassi, going into a overdose, want some quality time for myself.", leaveStatus: .rejected, from: .now, to: .now.addingTimeInterval(TimeInterval(86400 * 2))),
    ]
    
    @EnvironmentObject var appStates: AppStates
    
    var body: some View {
        ZStack {
            VStack {
               
                SectionHeading(text: "Applied Leaves")
                    .padding(.horizontal, 25)
                
                ForEach(self.$leaves, id: \.leaveId) { $leave in
                    if leave.fromDoctorid == self.doctor.doctorId {
                        LeaveCard(leave: $leave, wantButtons: false)
                            .padding(.horizontal, 25)
                    }
                }
                
                SectionHeading(text: "Ongoing Events")
                    .padding(.top, 20)
                    .padding(.horizontal, 25)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(self.$appStates.events, id: \.eventId) { event in
                            NavigationLink(destination: EventDetailsPage(event: event, wantEdit: false)) {
                                EventCard(event: event)
                                .frame(width: 275, height: 175, alignment: .topLeading)
                            }
                            
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
    
    @Previewable @State var doctor: Doctor = .init(doctorId: "doctor1", hospitalName: "Neelam", fullName: "Uddeshya SIngh", username: "doc#jettspanner123", password: "Saahil123s", height: 183, weight: 89, bloodGroup: .abn, doctorName: "Dr. Uddeshya SIngh", hospitalId: "hospital1", speciality: "Physiotherapist", medicalAcomplishment: "MBBS")
    DoctorAditionlPage(doctor: $doctor)
}
