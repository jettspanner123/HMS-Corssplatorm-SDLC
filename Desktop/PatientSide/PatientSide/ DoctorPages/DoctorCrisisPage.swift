//
//  DoctorCrisisPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 28/02/25.
//

import SwiftUI

struct DoctorCrisisPage: View {
    
    @State var patientDiagnoosis: String = ""
    @State var patientEmergencyState: EmergencyStatus = .none
    
    @State var isSubmitButtonClicked: Bool = false
    
    @State var showBottomSheet: Bool = false
    @State var bottomSheetTranslation: CGSize = .zero
    
    @State var showErrorMessage: Bool = false
    @State var errorMessage: String = ""
    @State var errorDescription: String = ""
    
    @State var showSuccessMessage: Bool = false
    @State var successMessage: String = ""
    
    
    @EnvironmentObject var appStates: AppStates
    
    func createCrisisRequest() {
        if self.patientDiagnoosis.isEmpty {
            self.errorMessage = "All Fields Required 🥲"
            self.errorDescription = "Make sure to fill out all the required fields."
            withAnimation {
                self.showErrorMessage = true
            }
            return
        }
        
        self.appStates.emergency.append(.init(patientDiagnosys: self.patientDiagnoosis, emergencyStatus: self.patientEmergencyState))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.patientDiagnoosis = ""
            self.patientEmergencyState = .none
            self.showSuccessMessage = true
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showSuccessMessage = false
            }
            
        }
        
    }
    
    
    var body: some View {
        ZStack(alignment: .top) {
            
            
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
            
            
            
            // MARK: Top background blur for header
            HStack {
                
            }
            .frame(maxWidth: .infinity, maxHeight: 140)
            .background(AppBackgroundBlur(radius: 15))
            .ignoresSafeArea()
            .offset(y: -15)
            .zIndex(11)
            
            // MARK: Page heading
            SecondaryPageHeader(headingText: "Emergency")
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
                self.createCrisisRequest()
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
                    
                    SectionHeading(text: "Patient Status")
                    
                    VStack {
                        HStack {
                            
                            Image(systemName: "circle.fill")
                                .foregroundStyle(.black.opacity(0.5))
                            
                            Text(self.patientEmergencyState.rawValue)
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundStyle(.black.opacity(0.5))
                            
                            Spacer()
                            
                            Image(systemName: "ellipsis")
                                .foregroundStyle(.black.opacity(0.5))
                        }
                        
                        if self.showBottomSheet {
                            
                            VStack {
                                SpaceBetweenTextView(firstText: EmergencyStatus.stable.rawValue, secondText: "")
                                    .onTapGesture {
                                        withAnimation {
                                            self.patientEmergencyState = .stable
                                            self.showBottomSheet = false
                                        }
                                    }
                                CustomDivider()
                                
                                SpaceBetweenTextView(firstText: EmergencyStatus.abnormal.rawValue, secondText: "")
                                    .onTapGesture {
                                        withAnimation {
                                            self.patientEmergencyState = .abnormal
                                            self.showBottomSheet = false
                                        }
                                    }
                                CustomDivider()
                                
                                SpaceBetweenTextView(firstText: EmergencyStatus.dangerious.rawValue, secondText: "")
                                    .onTapGesture {
                                        withAnimation {
                                            self.patientEmergencyState = .dangerious
                                            self.showBottomSheet = false
                                        }
                                    }
                                CustomDivider()
                                
                                SpaceBetweenTextView(firstText: EmergencyStatus.critical.rawValue, secondText: "")
                                    .onTapGesture {
                                        withAnimation {
                                            self.patientEmergencyState = .critical
                                            self.showBottomSheet = false
                                        }
                                    }
                            }
                            .padding(15)
                            .background(.white.gradient)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding(.top, 15)
                            .shadow(radius: 1)
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: self.showBottomSheet ? 275 : 55)
                    .padding(.horizontal, 20)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    .onTapGesture {
                        withAnimation {
                            self.showBottomSheet = true
                        }
                    }
                    
                    SectionHeading(text: "Short Diagnosys")
                        .padding(.top, 20)
                    
                    TextEditor(text: self.$patientDiagnoosis)
                        .frame(maxWidth: .infinity, minHeight: 150)
                        .padding(15)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                        .overlay {
                            HStack {
                                if self.patientDiagnoosis.isEmpty {
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
                .padding(.horizontal, 25)
                .padding(.bottom, 40)
            }
            
            
        }
        .background(.gray.opacity(0.2))
        .navigationBarBackButtonHidden()
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
