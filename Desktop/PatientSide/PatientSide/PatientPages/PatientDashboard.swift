//
//  PatientDashboard.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 28/02/25.
//

import SwiftUI

struct PatientDashboard: View {
   
    @Binding var user: SendUser
    
    @State var selectedTab: Int = 1
    @State var showProfilePage: Bool = false
    
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
                
                
                PageHeader(selectedTab: self.$selectedTab, id: self.selectedTab == 0 ? "patientHomePage" : "")
                    .zIndex(12)
                
                ScrollView(showsIndicators: false) {
                    if self.selectedTab == 0 {
                        PatientDashboardHomePage(user: self.$user)
                            .transition(.blurReplace)
                    } else if self.selectedTab == 1 {
                        PatientSearchPage(user: self.$user)
                            .transition(.blurReplace)
                    } else {
                        
                    }
                }
                
                PatientTabBarView(selectedTab: self.$selectedTab)
                    .offset(y: UIScreen.main.bounds.height - 165)
                    .zIndex(12)
                
                
                // MARK: Blur at the background of tab bar
                HStack {
                    
                }
                .frame(maxWidth: .infinity, minHeight: 100)
                .background(AppBackgroundBlur(radius: 10, opaque: false))
                .offset(y: UIScreen.main.bounds.height - 110)
            }
            .background(.gray.opacity(0.2))
        }
    }
}

#Preview {
    PatientDashboard(user: .constant(.init(id: "user1", fullName: "Uddeshya Singh", email: "uddeshya@gmail.com", location: "Patiala, Punjab", phoneNumber: "9875660105", userType: "user")))
}
