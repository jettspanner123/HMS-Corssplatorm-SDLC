//
//  RegistrationPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 13/02/25.
//

import SwiftUI
import FirebaseFirestore

struct RegistrationPage: View {
    
    @State var username: String = ""
    @State var password: String = ""
    @State var doctorId: String = ""
    @State var superAdminId: String = ""
    @State var adminId: String = ""
    
    @State var errorMessage: String = "Account Not Found"
    @State var errorDescription: String = "The account you are trying to enter either dosen't exist or has a different password."
    @State var showErrorMessage: Bool = false
    
    @State var showSuccessfullLoginDialog: Bool = false
    
    @State var isPasswordHidden: Bool = false
    @State var isSubmitButtonClicked: Bool = false
    
    @State var isDoctor: Bool = false
    @State var isAdmin: Bool = false
    @State var isSuperAdmin: Bool = false
    
    @EnvironmentObject var appStates: AppStates
    
    
    @State var user: SendUser = .init(id: "", fullName: "", email: "", location: "", phoneNumber: "", userType: "")
    @State var admin: SendAdmin = .init(adminName: "", hospitalId: "", asminUsername: "", password: "", isSuperAdmin: false, adminId: "")
    @State var doctor: Doctor = .init(doctorId: "", hospitalName: "", fullName: "", username: "", password: "", height: 198, weight: 198, bloodGroup: .ap, doctorName: "", hospitalId: "", speciality: "", medicalAcomplishment: "")
    
    // MARK: Function jisse username and password check ho raha hai and login v ho raha hai
    func performLogin() -> Void {
        self.isSubmitButtonClicked = true
        
        if self.username.isEmpty || self.password.isEmpty {
            self.errorMessage = "Empty Fields 😢"
            self.errorDescription = "Please fill all the essential fields."
            withAnimation(.spring(duration: 0.35)) {
                self.showErrorMessage = true
            }
            self.isSubmitButtonClicked = false
            return
        }
        
        if self.password.count < 8 {
            self.errorMessage = "Week Password 🥲"
            self.errorDescription = "The password entered dose not meet the require length of 8."
            
            withAnimation(.spring(duration: 0.35)) {
                self.showErrorMessage = true
            }
            self.isSubmitButtonClicked = false
            return
        }
        
        
        
        // MARK: Super admin
        if self.isSuperAdmin {
            for admin in self.appStates.admins {
                if admin.asminUsername == self.username && admin.password == self.password {
                    self.admin = admin
                    self.admin.isSuperAdmin = true
                    self.isSubmitButtonClicked = false
                    self.showSuccessfullLoginDialog = true
                    return
                }
            }
            
            self.errorMessage = "Account Not Found 🥲"
            self.errorDescription = "Either the username of password does not match."
            self.isSubmitButtonClicked = false
            withAnimation {
                self.showErrorMessage = true
            }
            return
        }
        
        // MARK: Normal admin
        if self.isAdmin {
            for admin in self.appStates.admins {
                print(admin)
                print(self.username + " - " + self.password)
                if admin.asminUsername == self.username && admin.password == self.password {
                    self.admin = admin
                    self.admin.isSuperAdmin = false
                    self.isSubmitButtonClicked = false
                    self.showSuccessfullLoginDialog = true
                    return
                }
            }
            
            self.errorMessage = "Account Not Found 🥲"
            self.errorDescription = "Either the username of password does not match."
            withAnimation {
                self.showErrorMessage = true
            }
            return
        }
        
        // MARK: Doctor
        if self.isDoctor {
            for doctor in self.appStates.doctors {
                if doctor.username == self.username && doctor.password == self.password {
                    self.doctor = doctor
                    self.isSubmitButtonClicked = false
                    self.showSuccessfullLoginDialog = true
                    return
                }
            }
            
            
            self.errorMessage = "Account Not Found 🥲"
            self.errorDescription = "Either the username of password does not match."
            withAnimation {
                self.showErrorMessage = true
            }
            return
        }
        
       // MARK: Patient
        for patient in self.appStates.users {
            if patient.email == self.username && patient.password == self.password {
                self.user = patient
                self.isSubmitButtonClicked = false
                self.showSuccessfullLoginDialog = true
                return
            }
            
            
            self.errorMessage = "Account Not Found 🥲"
            self.errorDescription = "Either the username of password does not match."
            withAnimation {
                self.showErrorMessage = true
            }
            return
        }
        
        self.isSubmitButtonClicked = false
        
        // MARK: Function khatam hai bhai yaha.
    }
    
    // MARK: Username jab change ho raha hai toh ye function call ho raha hai.
    private func onUsernameChange() {
        if self.username.lowercased().starts(with: "doc#") {
            withAnimation() {
                self.isDoctor = true
            }
        } else {
            withAnimation {
                self.isDoctor = false
            }
        }
        
        if self.username.lowercased().starts(with: "admin#") {
            withAnimation {
                self.isAdmin = true
            }
        } else {
            withAnimation {
                self.isAdmin = false
            }
        }
        
        if self.username.lowercased().starts(with: "superadmin#") {
            withAnimation {
                self.isSuperAdmin = true
            }
        } else {
            withAnimation {
                self.isSuperAdmin = false
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                if self.showErrorMessage {
                    VStack {
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(25)
                    .background(.black.opacity(0.5))
                    .shadow(radius: 1)
                    .zIndex(12)
                    
                }
                
                if self.showErrorMessage {
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
                    .transition(.offset(y: 1000))
                    .background(.white)
                    .clipShape(.rect(cornerRadius: 14))
                    .padding(.horizontal, 25)
                    .zIndex(31)
                    
                }
                
                
                VStack {
                    // MARK: Profile heading
                    if !self.isDoctor && !self.isAdmin && !self.isSuperAdmin {
                        Text("Log In")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.secondaryAccent)
                            .padding(.top, 50)
                            .padding(.bottom, 20)
                        
                    } else {
                        Text("Welcome, ")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.secondaryAccent)
                            .padding(.top, 50)
                        
                        Text(self.isDoctor ? "Doctor" : self.isAdmin ? "Admin" : "SuperAdmin")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.secondaryAccent)
                            .padding(.bottom, 20)
                            .offset(x: 5, y: -5)
                        
                    }
                    
                    
                    
                    
                    
                    //                     MARK: Useranem textfield
                    CustomTextField(text: self.$username, placeholder: "Username")
                        .autocapitalization(.none)
                        .onChange(of: self.username) {
                            self.onUsernameChange()
                        }
                        .overlay {
                            HStack {
                                
                                Image(systemName: "person.fill")
                                    .foregroundStyle(.black.opacity(0.5))
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                            
                        }
                    
                    
                    // MARK: Password textfield
                    ZStack {
                        
                        if self.isPasswordHidden {
                            TextField("Password", text: $password, prompt: Text("Password").foregroundStyle(.black.opacity(0.5)))
                                .autocapitalization(.none)
                                .frame(height: 55)
                                .padding(.horizontal, 55)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .shadow(radius: 1)
                                .overlay {
                                    HStack {
                                        Image(systemName: "key.fill")
                                            .foregroundStyle(.black.opacity(0.5))
                                            .rotationEffect(.degrees(45))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(20)
                                }
                        } else {
                            SecureField("Password", text: $password, prompt: Text("Password").foregroundStyle(.black.opacity(0.5)))
                                .autocapitalization(.none)
                                .frame(height: 55)
                                .padding(.horizontal, 50)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .shadow(radius: 1)
                                .overlay {
                                    HStack {
                                        Image(systemName: "key.fill")
                                            .foregroundStyle(.black.opacity(0.5))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(20)
                                }
                        }
                        
                        
                        HStack {
                            Image(systemName: self.isPasswordHidden ? "lock.open" : "lock")
                        }
                        .frame(maxWidth: 50, maxHeight: 50)
                        .padding(.horizontal, 10)
                        .clipped()
                        .onTapGesture {
                            self.isPasswordHidden.toggle()
                        }
                        .offset(x: self.isPasswordHidden ? 139 : 135)
                        
                    }
                    .padding(.top, 3)
                    
                    // MARK: Check if doctor
                    
                    if self.isDoctor {
                        SectionHeading(text: "Doctor Identification")
                            .padding(.top, 20)
                        
                        CustomTextField(text: self.$doctorId, placeholder: "Registration Id")
                            .autocapitalization(.none)
                            .overlay {
                                HStack {
                                    Image(systemName: "stethoscope")
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                            }
                    }
                    
                    // MARK: Check if super admin
                    
                    if self.isSuperAdmin {
                        SectionHeading(text: "Super Administration Identification")
                            .padding(.top, 20)
                        
                        CustomTextField(text: self.$superAdminId, placeholder: "Registration Id")
                            .autocapitalization(.none)
                            .overlay {
                                HStack {
                                    Image(systemName: "person.wave.2")
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                            }
                    }
                    
                    // MARK: Check if admin
                    
                    if self.isAdmin {
                        SectionHeading(text: "Administration Identification")
                            .padding(.top, 20)
                        
                        CustomTextField(text: self.$adminId, placeholder: "Registration Id")
                            .autocapitalization(.none)
                            .overlay {
                                HStack {
                                    Image(systemName: "person.wave.2")
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                            }
                        
                    }
                    
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
                    .padding(.top, 20)
                    .onTapGesture {
                        self.performLogin()
                    }
                    
                    
                    // MARK: Sign up button only if the account is not admin or doctor
                    
                    if !self.isDoctor && !self.isAdmin {
                        
                        HStack {
                            Text("Don't have an account?")
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            NavigationLink(destination: SignUpPage().navigationBarBackButtonHidden()) {
                                Text("Sign Up")
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundStyle(.blue.opacity(0.7))
                            }
                        }
                        .padding(.top, 10)
                        .padding(.horizontal, 20)
                        
                    }
                }
                .padding(25)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(.gray.opacity(0.2))
            }
            .navigationDestination(isPresented: self.$showSuccessfullLoginDialog) {
                if self.isAdmin || self.isSuperAdmin {
                    AdminDashboard(admin: self.$admin)
                        .navigationBarBackButtonHidden()
                }
                
                if self.isDoctor {
                    DoctorDashboard(doctor: self.$doctor)
                }
                
                if !self.isAdmin && !self.isDoctor && !self.isSuperAdmin {
                    PatientDashboard(user: self.$user)
                }
            }
        }
        
        
    }
}



#Preview {
    RegistrationPage()
}
