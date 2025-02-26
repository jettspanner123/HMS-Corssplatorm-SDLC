//
//  AddDepartmentPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 27/02/25.
//

import SwiftUI

struct AddDepartmentPage: View {
    
    
    @State var showSuccessMessage: Bool = false
    @State var successMessage: String = ""
    
    @State var showErrorMessage: Bool = false
    @State var errorMessage: String = ""
    @State var errorDescription: String = ""
    
    @State var isSubmitButtonClicked: Bool = false
    
    @State var departmentName: String = ""
    @State var departmentHospital: Hospital? = nil
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appStates: AppStates
    
    func createDepartment() -> Void {
        self.isSubmitButtonClicked = true
        
        if self.departmentName.isEmpty || self.departmentHospital == nil {
            self.errorMessage = "All Fields Required 🥲"
            self.errorDescription = "Make sure that all the fileds are filled properly."
            self.isSubmitButtonClicked = false
            withAnimation {
                self.showErrorMessage = true
            }
            return
        }
        
        self.appStates.departments.append(.init(departmentName: self.departmentName, hospitalId: self.departmentHospital!.hospitalId))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isSubmitButtonClicked = false
            self.departmentName = ""
            self.departmentHospital = nil
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
                    
                    Text("Add Admin")
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
                    //                self.handleAddAdmin()
                }
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        SectionHeading(text: "Department Details")
                        CustomTextField(text: self.$departmentName, placeholder: "Name")
                            .overlay {
                                HStack {
                                    Text("Ab")
                                        .font(.system(size: 15, weight: .bold, design: .rounded))
                                        .foregroundStyle(.black.opacity(0.5))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                            }
                        
                        SectionHeading(text: "Assign Hospital")
                            .padding(.top, 20)
                        
                        // MARK: for assigning hospital
                        NavigationLink(destination: AssignHospitalPage(hospital: self.$departmentHospital)) {
                            HStack {
                                Text(self.departmentHospital?.hospitalName ?? "None")
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
                        
                    }
                    .padding(.top, 160)
                    .padding(.horizontal, 25)
                }
                
            }
            .background(.gray.opacity(0.2))
            .navigationBarBackButtonHidden()
            
        }
    }
}
