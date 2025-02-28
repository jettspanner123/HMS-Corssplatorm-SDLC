//
//  DoctorDashboard.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 27/02/25.
//

import SwiftUI

struct DoctorDashboard: View {
    
    @State var selectedTab: Int = 2
    @State var showProfilePage: Bool = false
    
    
    @Binding var doctor: Doctor
    
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
                
                if self.showProfilePage {
                    DoctorProfile(showProfilePage: self.$showProfilePage, doctor: self.$doctor)
                        .transition(.offset(y: UIScreen.main.bounds.height))
                        .zIndex(21)
                }
                
                
                PageHeader_t(text: self.selectedTab == 0 ? "Abode" : self.selectedTab == 1 ? "Appointments" : "Aditionals", id: self.selectedTab == 0 ? "DoctorHomePage" : "", profileAction: {
                    withAnimation {
                        self.showProfilePage = true
                    }
                })
                .zIndex(12)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        if self.selectedTab == 0 {
                            DoctorDashboardHomePage(doctor: self.$doctor)
                                .transition(.blurReplace)
                        } else if self.selectedTab == 1 {
                            DoctorAppointmentPage()
                                .transition(.blurReplace)
                        } else {
                            DoctorAditionlPage(doctor: self.$doctor)
                        }
                    }
                }
                
                DoctorTabViewBar(selectedTab: self.$selectedTab)
                    .offset(y: UIScreen.main.bounds.height - 165)
                    .zIndex(12)
                
                // MARK: Blur at the background of tab bar
                HStack {
                    
                }
                .frame(maxWidth: .infinity, minHeight: 100)
                .background(AppBackgroundBlur(radius: 10, opaque: false))
                .offset(y: UIScreen.main.bounds.height - 110)
                .zIndex(11)
                
            }
            .background(.gray.opacity(0.2))}
    }
}

struct NotificationsPage: View {
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
                SecondaryPageHeader(headingText: "Notices")
                    .offset(y: 25)
                    .zIndex(12)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                    }
                    .padding(.top, 110)
                    .padding(.horizontal, 25)
                    .padding(.bottom, 40)
                }
            }
            .background(.appBackground)
            .onAppear {
            }
        }
    }
}



#Preview {
    
    @Previewable @State var doctor: Doctor = .init(doctorId: "doctor1", hospitalName: "Neelam", fullName: "Uddeshya SIngh", username: "doc#jettspanner123", password: "Saahil123s", height: 183, weight: 89, bloodGroup: .abn, doctorName: "Dr. Uddeshya SIngh", hospitalId: "hospital1", speciality: "Physiotherapist", medicalAcomplishment: "MBBS")
    NotificationsPage()
//    DoctorDashboard(doctor: $doctor)
//    DoctorProfile(showProfilePage: Binding.constant(true), doctor: $doctor)
    //    DoctorProfileEditPage(doctor: $doctor)
}
