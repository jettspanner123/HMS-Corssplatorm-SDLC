//
//  PatientDashboard.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 28/02/25.
//

import SwiftUI

struct PatientDashboard: View {
   
    @Binding var user: SendUser
    
    @State var selectedTab: Int = 0
    @State var showProfilePage: Bool = false
    @State var showEmergencyPage: Bool = false
    
    func dismiss() -> Void {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            let emergencyNumber = URL(string: "tel:102")
            UIApplication.shared.open(emergencyNumber!)
            withAnimation {
                self.showEmergencyPage = false
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                
                if self.showEmergencyPage {
                    VStack {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: 90, maxHeight: 90)
                        .background(.white.opacity(0.25))
                        .clipShape(Circle())
                        
                        Text("Emergency")
                            .font(.system(size: 25, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                        
                        Text("Your emergency contact will be notified in case of any emergency.")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundStyle(.white.opacity(0.5))
                            .padding(.horizontal, 50)
                            .padding(.top, 20)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.emergency.gradient)
                    .zIndex(20)
                    .transition(.offset(y: UIScreen.main.bounds.height))
                    .onAppear {
                        self.dismiss()
                    }
                }
               
                
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
                
                PatientTabBarView(showEmergencyPage: self.$showEmergencyPage, selectedTab: self.$selectedTab)
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
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    PatientDashboard(user: .constant(.init(id: "user1", fullName: "Uddeshya Singh", email: "uddeshya@gmail.com", location: "Patiala, Punjab", phoneNumber: "9875660105", userType: "user")))
}
