//
//  AdminPagePatientsPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 19/02/25.
//

import SwiftUI

struct AdminPagePatientsPage: View {
    
    @EnvironmentObject var appStates: AppStates
    
    @State var filteredPatients: Array<SendUser> = []
    
    @State var searchText: String = ""
    
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
            SecondaryPageHeader(headingText: "Patients")
            .offset(y: 25)
            .zIndex(12)
            
            ScrollView {
                VStack {
                    SectionHeading(text: "Search")
                    CustomTextField(text: self.$searchText, placeholder: "Search")
                        .onChange(of: self.searchText) {
                            self.filteredPatients = self.appStates.users.filter {
                                $0.fullName.lowercased().starts(with: self.searchText) || $0.id.lowercased().starts(with: self.searchText) || $0.fullName.contains(self.searchText)
                            }
                        }
                        .overlay {
                            HStack {
                                Image(systemName: "magnifyingglass")
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                    
                    
                    SectionHeading(text: "Patients")
                        .padding(.top, 20)
                    
                    if self.searchText.isEmpty {
                        ForEach(self.$appStates.users, id: \.id) { $patient in
                            PatientCard(patient: $patient)
                        }
                    } else {
                        
                        
                        // MARK: If the patient is not found
                        if self.filteredPatients.isEmpty {
                            VStack(spacing: 20) {
                                Image(systemName: "note.text")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .foregroundStyle(.gray.opacity(0.75))
                                
                                Text("No patient found.")
                                    .font(.system(size: 15, weight: .medium, design: .rounded))
                                    .foregroundStyle(.gray.opacity(0.75))
                            }
                            .padding(.top, 40)
                        } else {
                            ForEach(self.$filteredPatients, id: \.id) { $patient in
                                PatientCard(patient: $patient)
                            }
                        }
                        
                    }
                    
                    
                }
                .padding(.top, 110)
                .padding(.horizontal, 25)
            }
        }
        .background(.gray.opacity(0.2))
        .navigationBarBackButtonHidden()
    }
}
