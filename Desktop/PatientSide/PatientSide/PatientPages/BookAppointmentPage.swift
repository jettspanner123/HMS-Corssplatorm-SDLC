//
//  BookAppointmentPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 28/02/25.
//

import SwiftUI

struct BookAppointmentPage: View {
    @Binding var doctor: Doctor
    @Binding var patient: SendUser
    
    @State var appointmentDescription: String = ""
    
    @State var showErrorMessage: Bool = false
    @State var errorMessage: String = ""
    @State var errorDescription: String = ""
    
    @State var showSuccessMessage: Bool = false
    @State var successMessage: String = ""
    
    @State var appintmentDate: Date = .now
    @State var appointmentTime: Date = .now
    
    static func dateFromString(_ timeString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.date(from: timeString) ?? Date()
    }
    
    @EnvironmentObject var appStates: AppStates
    
    @State var doctorSlots: Array<(String, String)> = [
        ("Working", "9:00 AM"),
        ("Working", "10:00 AM"),
        ("Working", "11:00 AM"),
        ("Working", "12:00 AM"),
        ("Break", "1:00 AM"),
        ("Working", "2:00 AM"),
        ("Working", "3:00 AM"),
        ("Working", "4:00 AM"),
        ("Working", "5:00 AM"),
        ("Working", "6:00 AM")
    ]
    
    func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:MM a"
        return dateFormatter.string(from: date)
    }
    
    func createAppointment() -> Void {
        if self.appointmentDescription.isEmpty {
            self.errorMessage = "All Fields Required 🥲"
            self.errorDescription = "Make sure that all the fields are filled."
            self.isSubmitButtonClicked = false
            withAnimation {
                self.showErrorMessage = true
            }
            return
        }
        self.isSubmitButtonClicked = true
        
        
        for appointment in self.appStates.appointments {
            if self.patient.id == appointment.patientId && self.appintmentDate == appointment.appointmentDate {
                self.errorMessage = "Already Exists 🥲"
                self.errorDescription = "You already have an appointment on this date."
                withAnimation {
                    self.showErrorMessage = true
                }
                return
            }
            
        }
        
        self.appStates.appointments.append(.init(appointmentDate: self.appintmentDate, appointmentTime: self.appointmentTime, doctorId: self.doctor.doctorId, doctorName: self.doctor.doctorName, patientId: self.patient.id , patientName: self.patient.fullName, appointmentType: .upcoming))

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
           
            self.successMessage = "Appointment Added Successfully"
            withAnimation {
                self.showSuccessMessage = true
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    self.showSuccessMessage = false
                }
            }
        }
    }
    
    @State var selectedTimeSlot = "9:00 AM"
    @State var isSubmitButtonClicked: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            
            if self.showErrorMessage {
                VStack {
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(25)
                .background(.black.opacity(0.5))
                .shadow(radius: 1)
                .zIndex(20)
                
            }
            
            if self.showErrorMessage {
                VStack {
                    
                    VStack {
                        Text(self.errorMessage)
                            .font(.system(size: 25, weight: .bold, design: .rounded))
                            .foregroundStyle(.secondary)
                        
                        Text(self.errorDescription)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 20)
                        
                        HStack {
                            Text("I Understand")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(.appOrange.gradient)
                        .clipShape(.rect(cornerRadius: 15))
                        .onTapGesture {
                            withAnimation(.spring(duration: 0.45)) {
                                self.showErrorMessage = false
                            }
                        }
                        
                    }
                    .padding(30)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .clipShape(.rect(cornerRadius: 14))
                    .padding(.horizontal, 25)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.offset(y: 1000))
                .zIndex(31)
            }
            
            
            
            // MARK: Success Prompt
            if self.showSuccessMessage {
                HStack {
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 80)
                .background(AppBackgroundBlur(radius: 10, opaque: false))
                .background(
                    LinearGradient(gradient: Gradient(colors: [.black.opacity(0.5), .clear]), startPoint: .top, endPoint: .bottom)
                )
                .transition(.opacity)
                .zIndex(20)
                
            }
            
            if self.showSuccessMessage {
                Text(self.successMessage)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(15)
                    .background(.appGreen.gradient)
                    .clipShape(Capsule())
                    .shadow(radius: 2)
                    .offset(y: 30)
                    .transition(.offset(y: -200))
                    .zIndex(21)
                
            }
            
            // MARK: Top background blur for header
            HStack {
                
            }
            .frame(maxWidth: .infinity, maxHeight: 140)
            .background(AppBackgroundBlur(radius: 15))
            .ignoresSafeArea()
            .offset(y: -15)
            .zIndex(11)
            
            // MARK: Page heading
            SecondaryPageHeader(headingText: self.doctor.doctorName.split(separator: " ").prefix(2).joined(separator: " "))
                .offset(y: 25)
                .zIndex(12)
            
            HStack {
                if self.isSubmitButtonClicked {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text("Submit")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                }
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.appOrange.gradient)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(radius: 1)
            .padding(.horizontal, 25)
            .offset(y: UIScreen.main.bounds.height - 145)
            .zIndex(10)
            .onTapGesture {
                self.createAppointment()
            }
            
            // MARK: Bottom background blur
            HStack {
            }
            .frame(maxWidth: .infinity, minHeight: 100)
            .background(AppBackgroundBlur(radius: 5, opaque: false))
            .offset(y: UIScreen.main.bounds.height - 120)
            .zIndex(9)
            
            
            
            ScrollView(showsIndicators: false) {
                VStack {
                    SectionHeading(text: "Doctor Details")
                        .padding(.horizontal, 25)
                    
                    VStack {
                        SpaceBetweenTextView(firstText: "Name", secondText: self.doctor.doctorName)
                        CustomDivider()
                        
                        SpaceBetweenTextView(firstText: "Speciality", secondText: self.doctor.speciality)
                        CustomDivider()
                        
                        SpaceBetweenTextView(firstText: "Username", secondText: self.doctor.username)
                        CustomDivider()
                        
                        SpaceBetweenTextView(firstText: "Medical Acomplishment", secondText: self.doctor.medicalAcomplishment)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(15)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    .padding(.horizontal, 25)
                    
                    SectionHeading(text: "Slots")
                        .padding(.top, 20)
                        .padding(.horizontal, 25)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(self.doctorSlots.indices, id: \.self) { index in
                                if doctorSlots[index].0 == "Working" {
                                    Text(doctorSlots[index].1)
                                        .font(.system(size: 15, weight: .regular, design: .rounded))
                                        .foregroundStyle(self.selectedTimeSlot == doctorSlots[index].1 ? .white : .black.opacity(0.5))
                                        .padding(15)
                                        .background(self.selectedTimeSlot == doctorSlots[index].1 ? .appOrange : .white)
                                        .clipShape(Capsule())
                                        .shadow(radius: 1)
                                        .onTapGesture {
                                            withAnimation {
                                                self.selectedTimeSlot = doctorSlots[index].1
                                            }
                                        }
                                } else {
                                    Text(doctorSlots[index].1)
                                        .font(.system(size: 15, weight: .regular, design: .rounded))
                                        .foregroundStyle(.white)
                                        .padding(15)
                                        .background(.appRed.gradient)
                                        .clipShape(Capsule())
                                        .shadow(radius: 1)
                                }
                            }
                        }
                        .padding(.horizontal, 25)
                    }
                    .scrollClipDisabled()
                    
                    
                    SectionHeading(text: "Appointment Date")
                        .padding(.top, 20)
                        .padding(.horizontal, 25)
                    
                    HStack {
                        DatePicker("Date", selection: self.$appintmentDate, in: .now...Date().addingTimeInterval(60*60*24*7) ,displayedComponents: .date)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .padding(.horizontal, 25)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    .padding(.horizontal, 25)
                    
                     
                    SectionHeading(text: "Appointment Description")
                        .padding(.top, 20)
                        .padding(.horizontal, 25)
                    
                    
                    // MARK: Appoint ment description
                    TextEditor(text: self.$appointmentDescription)
                        .frame(maxWidth: .infinity, minHeight: 250)
                        .padding(15)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                        .padding(.horizontal, 25)
                    
                             
                }
                .padding(.top, 110)
                .padding(.bottom, 100)
            }

        }
        .background(.gray.opacity(0.2))
        .navigationBarBackButtonHidden()
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

#Preview {
    @Previewable @State var doctor: Doctor = .init(doctorId: "doctor1", hospitalName: "Neelam", fullName: "Uddeshya SIngh", username: "jettspanner123", password: "Saahil123s", height: 183, weight: 89, bloodGroup: .abn, doctorName: "Dr. Uddeshya SIngh", hospitalId: "hospital1", speciality: "Physiotherapist", medicalAcomplishment: "MBBS")
    @Previewable @State var admin: SendAdmin = .init(adminName: "", hospitalId: "", asminUsername: "", password: "", isSuperAdmin: true, adminId: "")
    @Previewable @State var user: SendUser = .init(id: "user1", fullName: "Uddeshya Singh", email: "uddeshya@gmail.com", location: "Patiala, Punjab", phoneNumber: "9875660105", userType: "")
    
    BookAppointmentPage(doctor: $doctor, patient: $user)
}
