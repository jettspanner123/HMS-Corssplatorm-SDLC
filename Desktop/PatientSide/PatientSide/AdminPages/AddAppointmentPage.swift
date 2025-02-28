//
//  AddAppointmentPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 27/02/25.
//

import SwiftUI

struct AddAppointmentPage: View {
    
    @State var showSuccessMessage: Bool = false
    @State var successMessage: String = ""
    
    @State var showErrorMessage: Bool = false
    @State var errorMessage: String = ""
    @State var errorDescription: String = ""
    
    @State var isSubmitButtonClicked: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appStates: AppStates
    
    @State var chooseDoctor: Doctor? = nil
    @State var choosePatient: SendUser? = nil
    @State var appointmentDate: Date = .now
    @State var appointmentTime: Date = .now
    
    func createAppointment() -> Void {
        
        self.isSubmitButtonClicked = true
        
        if self.chooseDoctor == nil || self.choosePatient == nil  {
            self.errorMessage = "All Fields Requred 🥲"
            self.errorDescription = "Make sure that all fields are filed properly."
            self.isSubmitButtonClicked = false
            withAnimation {
                self.showErrorMessage = true
            }
            return
        }
        
        
        self.appStates.appointments.append(.init(appointmentDate: self.appointmentDate, appointmentTime: self.appointmentTime, doctorId: self.chooseDoctor!.doctorId, doctorName: self.chooseDoctor!.doctorName, patientId: self.choosePatient!.id, patientName: self.choosePatient!.fullName, appointmentType: .upcoming))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isSubmitButtonClicked = false
            self.chooseDoctor = nil
            self.choosePatient = nil
            self.appointmentDate = .now
            self.appointmentTime = .now
            self.successMessage = "Appointment Added Successfully"
            
            withAnimation {
                self.showSuccessMessage = true
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.showSuccessMessage = false
                }
            }

        }
    }
    
    var body: some View {
        NavigationStack {
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
                
                
                // MARK: Blur background
                HStack {
                }
                .frame(maxWidth: .infinity)
                .frame(height: 220)
                .background(
                    AppBackgroundBlur(radius: 20, opaque: false)
                )
                .offset(y: -70)
                .zIndex(11)
                
                // MARK: Heading Text
                HStack(spacing: 15) {
                    
                    HStack {
                        Image(systemName: "arrow.left")
                    }
                    .frame(maxWidth: 45, maxHeight: 45)
                    .background(.white)
                    .clipShape(Circle())
                    .shadow(radius: 1)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                    Text("Add Lineup")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundStyle(.secondaryAccent)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 50)
                .padding(.bottom, 20)
                .padding(30)
                .zIndex(12)
                
                
                // MARK: Submit button
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
                
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        SectionHeading(text: "Choose Doctor")
                        
                        // MARK: Choose doctor button
                        NavigationLink(destination: AssignDoctorPage(doctor: self.$chooseDoctor)) {
                            HStack {
                                Text(self.chooseDoctor?.doctorName ?? "None")
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 55)
                            .padding(.horizontal, 55)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(radius: 1)
                            .overlay {
                                HStack {
                                    Image(systemName: "building.columns.fill")
                                        .foregroundStyle(.black.opacity(0.5))
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.black.opacity(0.5))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                            }
                        }
                        
                        SectionHeading(text: "Choose Patient")
                            .padding(.top, 20)
                        
                        // MARK: Choose patient
                        NavigationLink(destination: AssignPatientPage(patient: self.$choosePatient)) {
                            HStack {
                                Text(self.choosePatient?.fullName ?? "None")
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 55)
                            .padding(.horizontal, 55)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(radius: 1)
                            .overlay {
                                HStack {
                                    Image(systemName: "building.columns.fill")
                                        .foregroundStyle(.black.opacity(0.5))
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.black.opacity(0.5))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                            }
                        }
                        
                        
                        // MARK: Date and time selection
                        
                        SectionHeading(text: "Lineup Date & Time")
                            .padding(.top, 20)
                        
                        DatePicker("Date", selection: self.$appointmentDate, in: Date()...Date().addingTimeInterval(TimeInterval(86400 * 7)), displayedComponents: .date)
                            .tint(.appOrange)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .padding(.horizontal, 15)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(radius: 1)
                        
                        DatePicker("Time", selection: self.$appointmentDate, displayedComponents: .hourAndMinute)
                            .tint(.appOrange)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .padding(.horizontal, 15)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(radius: 1)
                        
 
                        

                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 160)
                    .padding(.bottom, 40)
                }
            }
            .background(.gray.opacity(0.2))
            .navigationBarBackButtonHidden()
        }
    }
}
