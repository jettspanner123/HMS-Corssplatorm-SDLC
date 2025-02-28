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
    
    @EnvironmentObject var appStates: AppStates
    
    @State var currentDoctorPatients: Array<SendUser> = []
    
    func fetchPatientsForCurrentDoctor() {
        
        
        // MARK: Creatating a temp list for holding all the id's as string
        var patientList: Array<String> = []
        
        
        // MARK: Pushing all the string of id's to the list
        for appointment in self.appStates.appointments {
            if appointment.doctorId == self.doctor.doctorId {
                patientList.append(appointment.patientId)
            }
        }
        
        
        // MARK: Fetching the patient object from the id's
        for patientId in patientList {
            for patient in self.appStates.users {
                if patientId == patient.id {
                    self.currentDoctorPatients.append(patient)
                }
            }
        }
        
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
            SecondaryPageHeader(headingText: "Details", id: .doctorDetails) {
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
                                Text(String(self.currentDoctorPatients.count))
                                    .font(.system(size: 50, weight: .bold, design: .monospaced))
                                    .foregroundStyle(.white)
                            }
                            
                            Text("Patients")
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundStyle(.white.opacity(0.5))
                            
                            
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .padding(20)
                        .background(
                            .appOrange.gradient
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                        
                        
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
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    
                    SectionHeading(text: "Patients")
                        .padding(.top, 20)
                    
                    ForEach(self.$currentDoctorPatients, id: \.id) { $patient in
                        NavigationLink(destination: PatientDetailsPage(patient: $patient)) {
                            PatientCard(patient: $patient)
                        }
                        
                    }
                    
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
        .onAppear {
            self.fetchPatientsForCurrentDoctor()
        }
    }
}




