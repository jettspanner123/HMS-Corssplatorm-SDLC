//
//  DoctorProfileEditPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 27/02/25.
//

import SwiftUI


struct DoctorProfileEditPage: View {
    
    @Binding var doctor: Doctor
    var body: some View {
        ZStack(alignment: .top) {
            // MARK: Top background blur for header
            HStack {
                
            }
            .frame(maxWidth: .infinity, maxHeight: 140)
            .background(AppBackgroundBlur(radius: 15))
            .ignoresSafeArea()
            .offset(y: -15)
            .zIndex(11)
            
            SecondaryPageHeader(headingText: "Edit")
                .offset(y: 25)
                .zIndex(12)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    
                    SectionHeading(text: "Public Details")
                    CustomTextField(text: self.$doctor.doctorName, placeholder: "Name")
                        .overlay {
                            HStack {
                                Text("Ab")
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                    
                    CustomTextField(text: self.$doctor.speciality, placeholder: "Speciality")
                        .overlay {
                            HStack {
                                Image(systemName: "hand.raised.fill")
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                    
                    CustomTextField(text: self.$doctor.username, placeholder: "Username")
                        .overlay {
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                    
                    Text("Make sure that the username should have doc# at the start for the login system to work smoothly.")
                        .font(.system(size: 10, weight: .medium, design: .rounded))
                        .foregroundStyle(.gray.opacity(0.9))
                        .padding(.horizontal, 5)
                        .padding(.vertical, 5)
                    
                    // MARK: Height
                    HStack {
                        Text(String(format: "%.0f cm", self.doctor.height))
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .padding(.horizontal, 55)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    .overlay {
                        HStack {
                            Image(systemName: "figure.stand")
                                .foregroundStyle(.black.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                    }
                    
                    
                    // MARK: Weight
                    HStack {
                        Text(String(format: "%.0f cm", self.doctor.weight))
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .padding(.horizontal, 55)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    .overlay {
                        HStack {
                            Image(systemName: "scalemass.fill")
                                .foregroundStyle(.black.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                    }
                    
                    SectionHeading(text: "Other Informations")
                        .padding(.top, 20)
                    
                    CustomTextField(text: self.$doctor.phoneNumber, placeholder: "Phone Number")
                        .keyboardType(.numberPad)
                        .overlay {
                            HStack {
                                Image(systemName: "phone.fill")
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                    
                    SectionHeading(text: "Hospital Information")
                        .padding(.top, 20)
                    
                    CustomTextField(text: self.$doctor.doctorId, placeholder: "Doctor Id")
                        .disabled(true)
                        .overlay {
                            HStack {
                                Text("Id")
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                    
                    CustomTextField(text: self.$doctor.hospitalId, placeholder: "Hospital Id")
                        .disabled(true)
                        .overlay {
                            HStack {
                                Image(systemName: "building.columns.fill")
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                    
                    CustomTextField(text: self.$doctor.hospitalName, placeholder: "Hospital Name")
                        .disabled(true)
                        .overlay {
                            HStack {
                                Text("H")
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                    
                }
                .padding(.top, 110)
                .padding(.horizontal, 25)
                .padding(.bottom, 60)
            }
        }
        .background(.gray.opacity(0.2))
        .navigationBarBackButtonHidden()
    }
}
