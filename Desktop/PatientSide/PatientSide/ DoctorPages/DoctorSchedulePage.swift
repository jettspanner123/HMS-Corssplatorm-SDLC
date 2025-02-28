//
//  DoctorSchedulePage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 27/02/25.
//

import SwiftUI

struct DoctorSchedulePage: View {
    
    @Binding var doctor: Doctor
    
    @State var showErrorMessage: Bool = false
    @State var errorMessage: String = ""
    @State var errorDescription: String = ""
    
    @State var showSuccessMessage: Bool = false
    @State var successMessage: String = ""
    
    @State var showSchedule: Bool = false
    
    
    @State var isSubmitButtonClicked: Bool = false
    
    @State private var shiftStartTime: Date = {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: Date())
        components.hour = 8
        components.minute = 0
        return calendar.date(from: components) ?? Date()
    }()
    
    @State private var shiftDuration: Int = 5
    @State private var breakStartTime: Date = {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: Date())
        components.hour = 13
        components.minute = 0
        return calendar.date(from: components) ?? Date()
    }()
    
    @State var maximumPatientsPerSlot: Int = 0
    
    @State var breakDuration: Int = 1
    
    @State var shiftEndTime: Date = .now
    
    func manageSchedule() -> Void {
        self.isSubmitButtonClicked = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isSubmitButtonClicked = false
            
            self.successMessage = "Schedule Set Successfully"
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
    
    func calculateEndTime() {
        let calendar = Calendar.current
        let adjustedEndTime = calendar.date(byAdding: .hour, value: shiftDuration, to: shiftStartTime)
        if let newEndTime = adjustedEndTime {
            self.shiftEndTime = newEndTime
        }
    }
    
    
    var body: some View {
        ZStack(alignment: .top) {
            
            // MARK: Error backdrop
            if self.showErrorMessage {
                VStack {
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(25)
                .background(.black.opacity(0.5))
                .shadow(radius: 1)
                .zIndex(20)
                
            }
            
            // MARK: Bottom background blur
            HStack {
            }
            .frame(maxWidth: .infinity, minHeight: 100)
            .background(AppBackgroundBlur(radius: 5, opaque: false))
            .offset(y: UIScreen.main.bounds.height - 120)
            .zIndex(9)
            
            
            
            
            // MARK: Show error message
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
            SecondaryPageHeader(headingText: "Schedule")
                .offset(y: 25)
                .zIndex(12)
            
            // MARK: Submit button
            HStack {
                if self.isSubmitButtonClicked {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text("Set Schedule")
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
                self.manageSchedule()
            }
            
            ScrollView(showsIndicators: false) {
                VStack {
                    SectionHeading(text: "Shift Details")
                    
                    // MARK: Schedule start time
                    HStack {
                        DatePicker("Start Time", selection: self.$shiftStartTime, displayedComponents: .hourAndMinute)
                            .onChange(of: self.shiftStartTime) {
                                self.calculateEndTime()
                            }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 15)
                    .frame(height: 55)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    
                    // MARK: Shift Duration time
                    HStack {
                        HStack {
                            Stepper("Duration", value: self.$shiftDuration, in: 5...20)
                                .tint(.appOrange)
                                .onChange(of: self.shiftDuration) {
                                    self.calculateEndTime()
                                }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 15)
                        .frame(height: 55)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                        
                        HStack {
                            Text("\(self.shiftDuration) hrs")
                        }
                        .frame(width: 55, height: 55)
                        .padding(.horizontal, 15)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                    }
                    
                    HStack {
                        
                        Text("Patients Per Slot")
                        
                        Spacer()
                        Picker("Start Time", selection: self.$maximumPatientsPerSlot) {
                            ForEach([0, 1, 2, 3, 4, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60], id: \.self) { index in
                                Text("\(index) Patients").tag(index)
                            }
                        }
                        .tint(.appOrange)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 15)
                    .frame(height: 55)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    
                    
                    // MARK: break details heading
                    SectionHeading(text: "Break Details")
                        .padding(.top, 20)
                    
                    HStack {
                        DatePicker("Break Time", selection: self.$breakStartTime, displayedComponents: .hourAndMinute)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 15)
                    .frame(height: 55)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    
                    
                    HStack {
                        HStack {
                            Stepper("Duration", value: self.$breakDuration, in: 0...3)
                                .tint(.appOrange)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 15)
                        .frame(height: 55)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                        
                        HStack {
                            Text("\(self.breakDuration) hrs")
                        }
                        .frame(width: 55, height: 55)
                        .padding(.horizontal, 15)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                    }
                    
                    
                    SectionHeading(text: "")
                        .padding(.top, 20)
                    
                    
                    // MARK: End time
                    HStack {
                        DatePicker("End Time", selection: self.$shiftEndTime, displayedComponents: .hourAndMinute)
                            .disabled(true)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 15)
                    .frame(height: 55)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    
                    
                }
                .padding(.top, 110)
                .padding(.horizontal, 25)
            }
            
        }
        .background(.gray.opacity(0.2))
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    
    @Previewable @State var doctor: Doctor = .init(doctorId: "doctor1", hospitalName: "Neelam", fullName: "Uddeshya SIngh", username: "jettspanner123", password: "Saahil123s", height: 183, weight: 89, bloodGroup: .abn, doctorName: "Dr. Uddeshya SIngh", hospitalId: "hospital1", speciality: "Physiotherapist", medicalAcomplishment: "MBBS")
    DoctorSchedulePage(doctor: $doctor)
}
