//
//  AdminDashboard.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 19/02/25.

import SwiftUI



struct AdminDashboard: View {
    
    @State var selectedTab: Int = 0
    @State var headerOffset: CGFloat = 0
    @State var addPageTranslate: CGSize = .zero
    
    @EnvironmentObject var appStates: AppStates
    
    @Binding var admin: SendAdmin
    
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
                    VStack {
                        VStack {
                            
                            Capsule()
                                .fill(.appOrange.opacity(0.25))
                                .stroke(.black.opacity(0.5), lineWidth: 0.5)
                                .frame(maxWidth: 50, maxHeight: 15)
                            
                            
                            // MARK: Bottom sheet headign
                            Text("Create Entity")
                                .font(.system(size: 30, weight: .bold, design: .rounded))
                                .foregroundStyle(.secondaryAccent)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 20)
                            
                            NavigationLink(destination: AddPatientPage()) {
                                AdminAddSomethingChoice(image: "person.fill", heading: "Patient")
                            }
                            
                            NavigationLink(destination: AddDoctorPage()) {
                                AdminAddSomethingChoice(image: "stethoscope", heading: "Doctor")
                            }
                            
                            NavigationLink(destination: EmptyView()) {
                                AdminAddSomethingChoice(image: "folder.fill", heading: "Department")
                            }
                            
                            if self.admin.isSuperAdmin {
                                NavigationLink(destination: CreateHospitalPage()) {
                                    AdminAddSomethingChoice(image: "building.columns.fill", heading: "Hospital")
                                }
                                
                                NavigationLink(destination: AddAdminPage()) {
                                    AdminAddSomethingChoice(image: "person.crop.circle.badge.checkmark", heading: "Admin")
                                }
                            }
                            
                            Spacer()
                                .frame(maxWidth: .infinity, maxHeight: 20)
                            
                        }
                        .frame(maxWidth: .infinity)
                        .padding(25)
                        .background(.appBackground)
                        .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 15, topTrailing: 15)))
                        .offset(y: self.addPageTranslate.height)
                        .edgesIgnoringSafeArea(.bottom)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if value.translation.height > .zero {
                                        withAnimation(.bouncy) {
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
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .transition(.move(edge: .bottom))
                    .edgesIgnoringSafeArea(.bottom)
                    .zIndex(21)
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
                            .transition(.blurReplace)
                    } else if self.selectedTab == 1 {
                        AdminDashboardPatientPage()
                            .transition(.blurReplace)
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
