//
//  AssignPatientPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 27/02/25.
//

import SwiftUI

struct AssignPatientPage: View {
    
    @State var searchText: String = ""
    @Binding var patient: SendUser?
    
    @Environment(\.presentationMode) var presentaionMode
    
    @State var filteredPatients: Array<SendUser> = []
    
    @EnvironmentObject var appStates: AppStates
    
    func handlePatientSelection(_ patient: SendUser) {
        self.patient = patient
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
                            self.filteredPatients = self.appStates.users.filter {
                                $0.fullName.lowercased().starts(with: self.searchText) || $0.id.lowercased().starts(with: self.searchText) || $0.fullName.contains(self.searchText)
                            }
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
                    
                    if self.filteredPatients.isEmpty && !self.searchText.isEmpty {
                        VStack(spacing: 20) {
                            Image(systemName: "note.text")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(.gray.opacity(0.75))
                            
                            Text("No patient found.")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                .foregroundStyle(.gray.opacity(0.75))
                        }
                        .padding(.top, 50)
                    }
                    
                    if self.searchText.isEmpty {
                        ForEach(self.$appStates.users, id: \.id) { $user in
                            PatientCard(patient: $user)
                                .onTapGesture {
                                    self.handlePatientSelection(user)
                                }
                        }
                        
                    } else {
                        ForEach(self.$filteredPatients, id: \.id) { $user in
                            PatientCard(patient: $user)
                                .onTapGesture {
                                    self.handlePatientSelection(user)
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

