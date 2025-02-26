//
//  AddAdminPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 24/02/25.
//

import SwiftUI

struct AddAdminPage: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appStates: AppStates
    
    @State var isSubmitButtonClicked: Bool = false
    
    @State var adminHospital: Hospital? = nil
    
    @State var adminName: String = ""
    @State var adminUsername: String = ""
    @State var adminId: String = ""
    @State var adminPassword: String = ""
    
    @State var showSuccessMessage: Bool = false
    @State var successMessage: String = ""
    
    @State var showErrorMessage: Bool = false
    @State var errorMessage: String = ""
    @State var errorDescription: String = ""
    
    func handleAddAdmin() -> Void {
        
        self.isSubmitButtonClicked = true
        
        if self.adminName.isEmpty || self.adminUsername.isEmpty || self.adminHospital == nil {
            self.errorMessage = "All Fields Requred 🥲"
            self.errorDescription = "Make sure that all fields are filed properly."
            self.isSubmitButtonClicked = false
            withAnimation {
                self.showErrorMessage = true
            }
            return
        }
        
        self.appStates.admins.append(.init(adminName: self.adminName, hospitalId: self.adminHospital!.hospitalId, asminUsername: self.adminUsername, password: self.adminPassword, isSuperAdmin: false, adminId: self.adminId))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isSubmitButtonClicked = false
            self.adminName = ""
            self.adminUsername = ""
            self.adminHospital = nil
            withAnimation {
                self.showSuccessMessage = true
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.showSuccessMessage = false
                }
            }

        }
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                
                
                
                if self.showErrorMessage {
                    VStack {
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(25)
                    .background(.black.opacity(0.5))
                    .shadow(radius: 1)
                    .zIndex(20)
                    
                }
                
                if self.showErrorMessage {
                    VStack {
                        
                        VStack {
                            Text(self.errorMessage)
                                .font(.system(size: 25, weight: .bold, design: .rounded))
                                .foregroundStyle(.secondary)
                            
                            Text(self.errorDescription)
                                .padding(.vertical, 20)
                            
                            HStack {
                                Text("I Understand")
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundStyle(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(.appOrange.gradient)
                            .clipShape(.rect(cornerRadius: 15))
                            .onTapGesture {
                                withAnimation(.spring(duration: 0.45)) {
                                    self.showErrorMessage = false
                                }
                            }
                            
                        }
                        .padding(30)
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .clipShape(.rect(cornerRadius: 14))
                        .padding(.horizontal, 25)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.offset(y: 1000))
                    .zIndex(31)
                }
                
                
                
                // MARK: Success Prompt
                if self.showSuccessMessage {
                    HStack {
                        
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background(AppBackgroundBlur(radius: 10, opaque: false))
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.black.opacity(0.5), .clear]), startPoint: .top, endPoint: .bottom)
                    )
                    .transition(.opacity)
                    .zIndex(20)
                    
                }
                
                if self.showSuccessMessage {
                    Text(self.successMessage)
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white)
                        .padding(15)
                        .background(.appGreen.gradient)
                        .clipShape(Capsule())
                        .shadow(radius: 2)
                        .offset(y: 30)
                        .transition(.offset(y: -200))
                        .zIndex(21)
                    
                }
                
                // MARK: Blur background
                HStack {
                }
                .frame(maxWidth: .infinity)
                .frame(height: 220)
                .background(
                    AppBackgroundBlur(radius: 20, opaque: false)
                )
                .offset(y: -70)
                .zIndex(11)
                
                // MARK: Heading Text
                HStack(spacing: 15) {
                    
                    HStack {
                        Image(systemName: "arrow.left")
                    }
                    .frame(maxWidth: 45, maxHeight: 45)
                    .background(.white)
                    .clipShape(Circle())
                    .shadow(radius: 1)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                    Text("Add Admin")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundStyle(.secondaryAccent)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 50)
                .padding(.bottom, 20)
                .padding(30)
                .zIndex(12)
                
                
                // MARK: Submit button
                HStack {
                    if self.isSubmitButtonClicked {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text("Submit")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(.appOrange.gradient)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(radius: 1)
                .padding(.horizontal, 25)
                .offset(y: UIScreen.main.bounds.height - 145)
                .zIndex(10)
                .onTapGesture {
                    self.handleAddAdmin()
                }
                
                
                ScrollView(showsIndicators: false) {
                    
                    VStack {
                        
                        SectionHeading(text: "Personal Information")
                        
                        // MARK: Admin name
                        CustomTextField(text: self.$adminName, placeholder: "Name")
                            .overlay {
                                HStack {
                                    Text("Ab")
                                        .font(.system(size: 15, weight: .bold, design: .rounded))
                                        .foregroundStyle(.black.opacity(0.5))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                            }
                        
                        
                        
                        // MARK: Admin username
                        CustomTextField(text: self.$adminUsername, placeholder: "Username")
                            .overlay {
                                HStack {
                                    Image(systemName: "person.fill")
                                        .foregroundStyle(.black.opacity(0.5))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                            }
                        
                        
                        SectionHeading(text: "Id's and Passwords")
                            .padding(.top, 20)
                        
                        
                        // MARK: Admin Id
                        HStack {
                            Text(self.adminId)
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundStyle(.black.opacity(0.5))
                                .lineLimit(1)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 55)
                        .padding(.horizontal, 55)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                        .overlay {
                            HStack {
                                Text("Id")
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundStyle(.black.opacity(0.5))
                                
                                Spacer()
                                
                                Image(systemName: "doc.on.clipboard")
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                        .onTapGesture {
                            withAnimation {
                                self.successMessage = "Admin Id Copied to Clipboard"
                                self.showSuccessMessage = true
                                
                                UIPasteboard.general.string = self.adminId
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        self.showSuccessMessage = false
                                    }
                                }
                            }
                        }
                        
                        // MARK: Password filed
                        HStack {
                            Text(self.adminPassword)
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundStyle(.black.opacity(0.5))
                                .lineLimit(1)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 55)
                        .padding(.horizontal, 55)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                        .overlay {
                            HStack {
                                Image(systemName: "key.fill")
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                        .onTapGesture {
                            withAnimation {
                                self.successMessage = "Admin Id Copied to Clipboard"
                                self.showSuccessMessage = true
                                
                                UIPasteboard.general.string = self.adminId
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        self.showSuccessMessage = false
                                    }
                                }
                            }
                        }
                        
                        
                        // MARK: Assign Hospital
                        
                        SectionHeading(text: "Assign Hospital")
                            .padding(.top, 20)
                        
                        NavigationLink(destination: AssignHospitalPage(hospital: self.$adminHospital)) {
                            HStack {
                                Text(self.adminHospital?.hospitalName ?? "None")
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 55)
                            .padding(.horizontal, 55)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(radius: 1)
                            .overlay {
                                HStack {
                                    Image(systemName: "building.columns.fill")
                                        .foregroundStyle(.black.opacity(0.5))
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.black.opacity(0.5))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                            }
                        }
                        
                        
                    }
                    .padding(.vertical, 160)
                    .padding(.horizontal, 25)
                    
                }
            }
            .background(.gray.opacity(0.2))
            .navigationBarBackButtonHidden()
            .onAppear {
                self.adminId = UUID().uuidString
                self.adminPassword = generateRandomPassword()
            }
            
        }
    }
}

struct AssignHospitalPage: View {
    @EnvironmentObject var appStates: AppStates
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var hospital: Hospital?
    @State var searchText: String = ""
    @State var filteredHospitals: Array<Hospital> = []
    
    func handleSetHospital(_ hospital: Hospital) {
        self.hospital = hospital
        self.presentationMode.wrappedValue.dismiss()
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
                            self.filteredHospitals = self.appStates.hospitals.filter {
                                $0.hospitalId.starts(with: self.searchText) || $0.hospitalName.starts(with: self.searchText) || $0.hospitalName.contains(self.searchText)
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
                    
                    if self.filteredHospitals.isEmpty && !self.searchText.isEmpty {
                        VStack(spacing: 20) {
                            Image(systemName: "note.text")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(.gray.opacity(0.75))
                            
                            Text("No hospital found.")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                .foregroundStyle(.gray.opacity(0.75))
                        }
                        .padding(.top, 50)
                    }
                    
                    if self.searchText.isEmpty {
                        ForEach(self.$appStates.hospitals, id: \.hospitalId) { $hospital in
                            HospitalCard(hospital: $hospital)
                                .onTapGesture {
                                    self.handleSetHospital(hospital)
                                }
                        }
                    } else {
                        ForEach(self.$filteredHospitals, id: \.hospitalId) { $hospital in
                            HospitalCard(hospital: $hospital)
                                .onTapGesture {
                                    self.handleSetHospital(hospital)
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

