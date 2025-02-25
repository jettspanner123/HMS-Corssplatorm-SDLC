//
//  AdminDashboard.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 19/02/25.
//

import SwiftUI



struct AdminDashboard: View {
    
    @State var selectedTab: Int = 0
    @State var headerOffset: CGFloat = 0
    @State var addPageTranslate: CGSize = .zero
    
    @EnvironmentObject var appStates: AppStates
    
    @Binding var admin: SendAdmin
    var admin_t: SendAdmin = .init(adminName: "", hospitalId: "", asminUsername: "", password: "", isSuperAdmin: true, adminId: "")
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                
                
                // MARK: Dark backdrop
                if self.appStates.showAddPage {
                    VStack {
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .background(.black.opacity(0.75))
                    .onTapGesture {
                        withAnimation(.spring(duration: 0.35)) {
                            self.appStates.showAddPage = false
                            self.addPageTranslate = .zero
                        }
                    }
                    .zIndex(20)
                    
                }
                
                
                
                
                
                // MARK: Show add page bottom screen
                if self.appStates.showAddPage {
                    CustomBottomSheet {
                        VStack {
                            
                            // MARK: Cusomt bottom sheet swipe indicator
                            Capsule()
                                .fill(.appOrange.opacity(0.35).gradient)
                                .frame(maxWidth: 50, maxHeight: 15)
                                .padding(.vertical, 10)
                            
                            
                            
                            
                            // MARK: Cusomt bottom sheet heading
                            HStack(spacing: 15) {
                                
                                
                                Text("Create Entity")
                                    .font(.system(size: 30, weight: .bold, design: .rounded))
                                    .foregroundStyle(.secondaryAccent)
                                    .padding(.top, 20)
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                            // MARK: If super admin show add admin, hospital Page
                            if self.admin_t.isSuperAdmin {
                                NavigationLink(destination: AddAdminPage()) {
                                    AdminAddSomethingChoice()
                                }
                                
                                NavigationLink(destination: CreateHospitalPage()) {
                                    AdminAddSomethingChoice()
                                }
                            }
                            
                            
                            // MARK: Add Patient link
                            NavigationLink(destination: AddPatientPage()) {
                                AdminAddSomethingChoice()
                            }
                            
                            // MARK: Add Doctor link
                            NavigationLink(destination: AddDoctorPage()) {
                                AdminAddSomethingChoice()
                            }
                            
                            // MARK: Add Hospital link
                            NavigationLink(destination: CreateHospitalPage()) {
                                AdminAddSomethingChoice()
                            }
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .padding(.top, 10)
                        .padding(.horizontal, 30)
                        .background(.white.gradient)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.top, self.admin_t.isSuperAdmin ? 20 : 100)
                        .edgesIgnoringSafeArea(.bottom)
                    }
                    .transition(.move(edge: .bottom))
                    .offset(y: self.addPageTranslate.height)
                    .zIndex(30)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                withAnimation(.bouncy) {
                                    if value.translation.height > .zero {
                                        self.addPageTranslate = value.translation
                                    }
                                }
                            }
                            .onEnded { value in
                                if value.translation.height > 100 {
                                    withAnimation(.spring(duration: 0.35)) {
                                        self.appStates.showAddPage = false
                                        self.addPageTranslate = .zero
                                    }
                                } else {
                                    withAnimation(.spring(duration: 0.35)) {
                                        self.addPageTranslate = .zero
                                    }
                                }
                                
                            }
                    )
                }
                
                
                // MARK: Top background blur for header
                HStack {
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 140)
                .background(AppBackgroundBlur(radius: 15))
                .ignoresSafeArea()
                .offset(y: -15)
                .zIndex(11)
                
                
                PageHeader(selectedTab: self.$selectedTab, id: "adminDashboard")
                    .zIndex(12)
                
                ScrollView(showsIndicators: false) {
                    if self.selectedTab == 0 {
                        AdminDashboardHomePage()
                    } else if self.selectedTab == 1 {
                    } else if self.selectedTab == 2 {
                        
                    } else if self.selectedTab == 3 {
                        
                    }
                }
                
                
                AdminTabViewBar(selectedTab: self.$selectedTab)
                    .offset(y: UIScreen.main.bounds.height - 165)
                    .zIndex(12)
                
                // MARK: Blur at the background of tab bar
                HStack {
                    
                }
                .frame(maxWidth: .infinity, minHeight: 100)
                .background(AppBackgroundBlur(radius: 10, opaque: false))
                .offset(y: UIScreen.main.bounds.height - 110)
                
            }
            .background(.gray.opacity(0.3))
        }
    }
}

struct AdminAddSomethingChoice: View {
    var body: some View {
        HStack {
            
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
        .background(.gray.opacity(0.2).gradient)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 1)
    }
}


#Preview {
    AdminDashboard(admin: .constant(.init(adminName: "", hospitalId: "", asminUsername: "", password: "", isSuperAdmin: true, adminId: "")))
}
