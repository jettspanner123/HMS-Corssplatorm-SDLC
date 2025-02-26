//
//  AvailableDoctorsPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 21/02/25.
//

import SwiftUI

struct AvailableDoctorsPage: View {
    
    
    // MARK: Search yaha hoga
    @State var searchText: String = ""
    
    @EnvironmentObject var appStates: AppStates
    
    
    @State var filterAvailableDoctors: Array<Doctor> = []
 
    
    var body: some View {
        NavigationStack {
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
                SecondaryPageHeader(headingText: "Doctors")
                    .offset(y: 25)
                    .zIndex(12)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        
                        SectionHeading(text: "Search")
                        
                        // MARK: Top Search Box
                        CustomTextField(text: self.$searchText, placeholder: "Search")
                            .onChange(of: self.searchText) {
                                self.filterAvailableDoctors = self.appStates.doctors.filter {
                                    $0.fullName.lowercased().starts(with: self.searchText.lowercased()) || $0.speciality.lowercased().starts(with: self.searchText.lowercased()) || $0.fullName.lowercased().contains(self.searchText.lowercased())
                                }
                            }
                            .overlay {
                                HStack {
                                    
                                    // MARK: Magnifying glass icon
                                    Image(systemName: "magnifyingglass")
                                        .foregroundStyle(.black.opacity(0.5))
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 15)
                            }
                        
                        SectionHeading(text: "Available Doctors")
                            .padding(.top, 20)
                        
                        if self.searchText.isEmpty {
                            ForEach(self.appStates.doctors, id: \.doctorId) { doctor in
                                NavigationLink(destination: DoctorDetailsPage(doctor: doctor)) {
                                    AvailableDoctorCard(doctor: doctor)
                                }
                            }
                        }
                        
                        if !self.searchText.isEmpty {
                            ForEach(self.filterAvailableDoctors, id: \.doctorId) { doctor in
                                NavigationLink(destination: DoctorDetailsPage(doctor: doctor)) {
                                    AvailableDoctorCard(doctor: doctor)
                                }
                            }
                        }
                            

                    }
                    .padding(.top, 110)
                    .padding(.bottom, 30)
                    .padding(.horizontal, 25)
                }
            }
            .background(.gray.opacity(0.3))
            .navigationBarBackButtonHidden()
        }
    }
}


struct AvailableDoctorCard: View {
    
    var doctor: Doctor
    var body: some View {
        HStack {
            HStack(spacing: 15) {
                Text(getInitials(name: self.doctor.fullName))
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(.appOrange.gradient))
                
                VStack(alignment: .leading) {
                    Text(self.doctor.doctorName)
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundStyle(.black.opacity(0.5))
                    
                    Text(self.doctor.speciality)
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                        .foregroundStyle(.black.opacity(0.35))
                    
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.appOrange.opacity(0.75))
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding(20)
        .background(.white.gradient)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 1)
    }
}
