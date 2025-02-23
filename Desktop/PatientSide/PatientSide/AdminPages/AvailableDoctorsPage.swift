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
    
    
    // MARK: Example doctors
    @State var availableDoctors: Array<Doctor> = [
        .init(doctorId: "123", hospitalName: "Neelam Hospital", fullName: "Uddeshya Singh", username: "doc#jettspanner123", password: "TanishqIsGay", doctorName: "Dr. Uddeshya Singh", hospitalId: "dskfjdklf", speciality: "Gayology", medicalAcomplishment: "Pride Mastery"),
        .init(doctorId: "456", hospitalName: "Apollo Hospitals", fullName: "Anika Sharma", username: "doc#anika_sharma", password: "SecurePassword1", doctorName: "Dr. Anika Sharma", hospitalId: "ghjklmnb", speciality: "Cardiology", medicalAcomplishment: "Pioneer in Minimally Invasive Cardiac Surgery"),
        .init(doctorId: "789", hospitalName: "Fortis Hospital", fullName: "Rohan Gupta", username: "doc#rohan_gupta", password: "AnotherStrongPassword", doctorName: "Dr. Rohan Gupta", hospitalId: "qwertyuiop", speciality: "Neurology", medicalAcomplishment: "Awarded for Excellence in Neurological Research"),
        .init(doctorId: "101", hospitalName: "Max Healthcare", fullName: "Priya Patel", username: "doc#priya_patel", password: "Password123", doctorName: "Dr. Priya Patel", hospitalId: "asdfghjkl", speciality: "Dermatology", medicalAcomplishment: "Specialist in Cosmetic Dermatology"),
        .init(doctorId: "112", hospitalName: "Columbia Asia Hospital", fullName: "Vikram Singh", username: "doc#vikram_singh", password: "MyPassword", doctorName: "Dr. Vikram Singh", hospitalId: "zxcvbnm", speciality: "Orthopedics", medicalAcomplishment: "Expert in Joint Replacement Surgery"),
        .init(doctorId: "131", hospitalName: "Manipal Hospital", fullName: "Isha Kapoor", username: "doc#isha_kapoor", password: "StrongPass", doctorName: "Dr. Isha Kapoor", hospitalId: "poiuytrewq", speciality: "Oncology", medicalAcomplishment: "Leading Researcher in Cancer Treatment"),
        .init(doctorId: "142", hospitalName: "Medanta - The Medicity", fullName: "Arjun Reddy", username: "doc#arjun_reddy", password: "SecurePass", doctorName: "Dr. Arjun Reddy", hospitalId: "lkjhgfdsa", speciality: "Internal Medicine", medicalAcomplishment: "Recognized for Outstanding Patient Care"),
        .init(doctorId: "153", hospitalName: "Sir Ganga Ram Hospital", fullName: "Natasha Khanna", username: "doc#natasha_khanna", password: "Password", doctorName: "Dr. Natasha Khanna", hospitalId: "mnbvcxz", speciality: "Pediatrics", medicalAcomplishment: "Dedicated to Children's Health"),
        .init(doctorId: "164", hospitalName: "BLK Super Speciality Hospital", fullName: "Aditya Chopra", username: "doc#aditya_chopra", password: "MySecretPassword", doctorName: "Dr. Aditya Chopra", hospitalId: "qazwsxedc", speciality: "Gastroenterology", medicalAcomplishment: "Specialist in Digestive Disorders"),
        .init(doctorId: "175", hospitalName: "Kokilaben Dhirubhai Ambani Hospital", fullName: "Simran Kaur", username: "doc#simran_kaur", password: "AnotherSecretPassword", doctorName: "Dr. Simran Kaur", hospitalId: "edcxszaq", speciality: "Ophthalmology", medicalAcomplishment: "Expert in Laser Eye Surgery")
    ]
    
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
                            .onChange(of: self.searchText) { newValue in
//                                for i in self.availableDoctors {
//                                    print(i.fullName.lowercased().starts(with: self.searchText.lowercased()))
//                                }
                                
                                self.filterAvailableDoctors = self.availableDoctors.filter {
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
                            ForEach(self.availableDoctors, id: \.doctorId) { doctor in
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


#Preview {
    AvailableDoctorsPage()
}
