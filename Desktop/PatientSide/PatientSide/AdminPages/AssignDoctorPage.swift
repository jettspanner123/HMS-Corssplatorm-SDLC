//
//  AssignDoctorPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 27/02/25.
//

import SwiftUI


struct AssignDoctorPage: View {
    
    @State var searchText: String = ""
    @Binding var doctor: Doctor?
    
    @Environment(\.presentationMode) var presentaionMode
    
    @State var filteredDoctors: Array<Doctor> = []
    
    @EnvironmentObject var appStates: AppStates
    
    func handleDoctorSelection(_ doctor: Doctor) {
        self.doctor = doctor
        self.presentaionMode.wrappedValue.dismiss()
    }
    
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
            
            // MARK: Page heading
            SecondaryPageHeader(headingText: "Select")
                .offset(y: 25)
                .zIndex(12)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    
                    SectionHeading(text: "Search")
                    CustomTextField(text: self.$searchText, placeholder: "Search Hospitals")
                        .onChange(of: self.searchText) {
                        }
                        .overlay {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                    
                    
                    SectionHeading(text: "Choose Hospital")
                        .padding(.top, 20)
                    
                    if self.filteredDoctors.isEmpty && !self.searchText.isEmpty {
                        VStack(spacing: 20) {
                            Image(systemName: "note.text")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(.gray.opacity(0.75))
                            
                            Text("No hospital found.")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                .foregroundStyle(.gray.opacity(0.75))
                        }
                        .padding(.top, 50)
                    }
                    
                    if self.searchText.isEmpty {
                        ForEach(self.$appStates.doctors, id: \.doctorId) { $doctor_t in
                            DoctorCard(doctor: doctor_t)
                                .onTapGesture {
                                    self.handleDoctorSelection(doctor_t)
                                }
                        }
                        
                    } else {
                        ForEach(self.$filteredDoctors, id: \.doctorId) { $doctor_t in
                            DoctorCard(doctor: doctor_t)
                                .onTapGesture {
                                    self.handleDoctorSelection(doctor_t)
                                }
                        }
                    }
                    
                }
                .padding(.horizontal, 25)
                .padding(.top, 110)
                .padding(.bottom, 40)
            }
        }
        .background(.gray.opacity(0.2))
        .navigationBarBackButtonHidden()
    }
}
