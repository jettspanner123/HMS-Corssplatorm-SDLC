//
//  DoctorDetailsPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 21/02/25.
//

import SwiftUI

struct DoctorDetailsPage: View {
    
    @State var doctor: Doctor
    @State var showEditDoctorPage: Bool = false
    
    
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
            SecondaryPageHeader(headingText: "Details", id: "doctorDetailPage") {
                self.showEditDoctorPage = true
            }
            .offset(y: 25)
            .zIndex(12)
            
            ScrollView {
                VStack {
                    
                    
                    SectionHeading(text: "Activities Today")
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                        
                        
                        // MARK: Patients about to see today
                        VStack {
                            HStack {
                                Text("28")
                                    .font(.system(size: 50, weight: .bold, design: .monospaced))
                                    .foregroundStyle(.opacity(0.5))
                                
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .frame(maxWidth: 30, maxHeight: 30)
                                    .foregroundStyle(
                                        LinearGradient(gradient: Gradient(colors: [.pink, .red]), startPoint: .bottomLeading, endPoint: .topTrailing)
                                    )
                            }
                            
                            Text("Patients")
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundStyle(.black.opacity(0.5))
                            
                            
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .padding(20)
                        .background(
                            .white.gradient
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                        
                        
                        // MARK: Patients seen today
                        HStack {
                            Text("")
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .padding(20)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.pink, .red]), startPoint: .bottomLeading, endPoint: .topTrailing)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                        
                        // MARK: Patients Pending
                    }
                    
                    
                    
                    SectionHeading(text: "Personal Details")
                        .padding(.top, 20)
                    
                    VStack {
                        
                        SpaceBetweenTextView(firstText: "Name", secondText: self.doctor.doctorName)
                            .padding(.horizontal, 25)
                        CustomDivider()
                        
                        
                        SpaceBetweenTextView(firstText: "Speciality", secondText: self.doctor.speciality)
                            .padding(.horizontal, 25)
                        CustomDivider()
                        
                        SpaceBetweenTextView(firstText: "Hospital Name", secondText: self.doctor.hospitalName)
                            .padding(.horizontal, 25)
                        CustomDivider()
                        
                        SpaceBetweenTextView(firstText: "Hospital Id", secondText: self.doctor.hospitalId)
                            .padding(.horizontal, 25)
                        CustomDivider()
                        
                        SpaceBetweenTextView(firstText: "Username", secondText: self.doctor.username)
                            .padding(.horizontal, 25)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.white.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    
                    SectionHeading(text: "Patients")
                        .padding(.top, 20)
                    
                    
                }
                .padding(.top, 110)
                .padding(.horizontal, 25)
                
            }
        }
        .background(.gray.opacity(0.3))
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: self.$showEditDoctorPage) {
            EditDoctorPage(doctor: self.$doctor)
        }
    }
}


struct SpaceBetweenTextView: View {
    
    var firstText: String
    var secondText: String
    
    var body: some View {
        HStack {
            Text(self.firstText)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundStyle(.black.opacity(0.75))
            
            Spacer()
            
            Text(self.secondText)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundStyle(.black.opacity(0.35))
            
        }
    }
}


struct CustomDivider: View {
    var body: some View {
        
        // MARK: Divider
        HStack {
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 1)
        .background(.black.opacity(0.1))
        .padding(.vertical, 5)
        
    }
}
