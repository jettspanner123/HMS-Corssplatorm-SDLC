//
//  ApplyLeavePage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 27/02/25.
//

import SwiftUI

struct ApplyLeavePage: View {
    
    @Binding var doctor: Doctor
    
    @State var isSubmitButtonClicked: Bool = false
    
    @State var leaveDescription: String = ""
    @State var leaveFrom: Date = .now
    @State var leaveTo: Date = .now
    
    @State var showSuccessMessage: Bool = false
    @State var successMessage: String = ""
    
    @State var showConfirmationMessage: Bool = false
    @State var isConfirmed: Bool = false
    
    @State var showErrorMessage: Bool = false
    @State var errorMessage: String = ""
    @State var errorDescription: String = ""
    
    @EnvironmentObject var appStates: AppStates
    
    func applyLeave() -> Void {
        
        if self.leaveDescription.isEmpty {
            self.errorMessage = "All Fields Required 🥲"
            self.errorDescription = "Make sure to fill all the fields correctly."
            withAnimation {
                self.showErrorMessage = true
            }
            return
        }
        
        
        self.isSubmitButtonClicked = true
        withAnimation {
            self.showConfirmationMessage = true
        }
        
        
        
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            
            if self.showConfirmationMessage {
                VStack {
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(25)
                .background(.black.opacity(0.5))
                .shadow(radius: 1)
                .zIndex(20)
            }
            
            if self.showConfirmationMessage {
                VStack {
                    VStack {
                       
                        Text("Do you want to apply for leave?")
                            .padding(.vertical, 20)
                            .padding(.bottom, 10)
                        
                        
                        // MARK: Okay button
                        HStack {
                            Text("Apply")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(.appOrange.gradient)
                        .clipShape(.rect(cornerRadius: 15))
                        .onTapGesture {
                            withAnimation {
                                self.showConfirmationMessage = false
                            }
                            
                            
                            // MARK: 
                            self.appStates.leaves.append(.init(fromDoctorid: self.doctor.doctorId, fromDoctorName: self.doctor.doctorName, leaveDescription: self.leaveDescription, leaveStatus: .pending, from: self.leaveFrom, to: self.leaveTo))
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.isSubmitButtonClicked = false
                                self.leaveFrom = .now
                                self.leaveTo = .now
                                self.leaveDescription = ""
                                
                                self.successMessage = "Leave Applied Successfully"
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
                        
                        // MARK: Cancel Button
                        HStack {
                            Text("Cancel")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundStyle(.appOrange)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(.white.gradient)
                        .clipShape(.rect(cornerRadius: 15))
                        .shadow(radius: 1)
                        .onTapGesture {
                            withAnimation(.spring(duration: 0.45)) {
                                self.showConfirmationMessage = false
                                self.isConfirmed = false
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
            SecondaryPageHeader(headingText: "Leave")
                .offset(y: 25)
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
                self.applyLeave()
            }
            
            
            ScrollView(showsIndicators: false) {
                VStack {
                    
                    SectionHeading(text: "Leave Duration")
                    
                    // MARK: From date picker
                    HStack {
                        DatePicker("From", selection: self.$leaveFrom, displayedComponents: .date)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)
                    .frame(height: 55)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    
                    // MARK: To date picker
                    HStack {
                        DatePicker("To", selection: self.$leaveTo, displayedComponents: .date)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)
                    .frame(height: 55)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    
                    SectionHeading(text: "Leave Description")
                        .padding(.top, 20)

                    
                    // MARK: Leave description
                    TextEditor(text: self.$leaveDescription)
                        .frame(maxWidth: .infinity, minHeight: 150)
                        .padding(15)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                        .overlay {
                            HStack {
                                if self.leaveDescription.isEmpty {
                                    Text("Description")
                                        .font(.system(size: 15, weight: .regular, design: .rounded))
                                        .foregroundStyle(.gray.opacity(0.75))
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding(25)
                            
                        }
                    
                    
                }
                .padding(.top, 110)
                .padding(.bottom, 40)
                .padding(.horizontal, 25)
            }
        }
        .background(.gray.opacity(0.2))
        .navigationBarBackButtonHidden()
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
