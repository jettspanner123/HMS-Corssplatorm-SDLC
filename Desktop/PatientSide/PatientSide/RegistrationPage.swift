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
    
    
    @State var user: SendUser = .init(id: "", fullName: "", email: "", location: "", phoneNumber: "", userType: "")
    @State var admin: SendAdmin = .init(adminName: "", hospitalId: "", asminUsername: "", password: "", isSuperAdmin: false, adminId: "")
    
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
        
        // MARK: Databse init
        let database = Firestore.firestore()
        
        // MARK: Check if super admin
        if self.isSuperAdmin {
            database.collection("superadmin").getDocuments() { (querySnapshot, error) in
                
                if self.superAdminId.isEmpty {
                    self.errorMessage = "Invalid Admin Id 🥲"
                    self.errorDescription = "The admin registration fields is empty or the id dosen't exists."
                    withAnimation(.spring(duration: 0.35)) {
                        self.showErrorMessage = true
                    }
                    self.isSubmitButtonClicked = false
                    return
                }
                
                if let _ = error {
                    self.errorMessage = "Connection Error! 😭"
                    self.errorDescription = "There was a error while connecting to the database. "
                    
                    withAnimation(.spring(duration: 0.35)) {
                        self.showErrorMessage = true
                    }
                    return
                }
                
                let availableSuperAdmins = querySnapshot!.documents.compactMap { doc in
                    try? doc.data(as: SendSuperAdmin.self)
                }
                
                for superadmin in availableSuperAdmins {
                    if superadmin.superadminUsername == self.username.lowercased() && superadmin.superadminPassword == self.password {
                        self.admin = .init(adminName: superadmin.superadminName, hospitalId: "", asminUsername: superadmin.superadminUsername, password: superadmin.superadminPassword, isSuperAdmin: true, adminId: superadmin.superadminId)
                        self.isSubmitButtonClicked = false
                        self.showSuccessfullLoginDialog = true
                        return
                    }
                }
                
                
                self.errorMessage = "Invalid Credentials 🥲"
                self.errorDescription = "Please make sure that that credentials match and are of same ground."
                
                withAnimation(.spring(duration: 0.35)) {
                    self.showErrorMessage = true
                }
                self.isSubmitButtonClicked = false
                return
            }
        }
        
        
        
        // MARK: Check if admin
        if self.isAdmin {
            
            database.collection("admins").getDocuments() { (querySnapshot, error) in
                
                // MARK: Make sure that the admin has entered the id
                if self.adminId.isEmpty {
                    self.errorMessage = "Invalid Admin Id 🥲"
                    self.errorDescription = "The admin registration fields is empty or the id dosen't exists."
                    
                    withAnimation(.spring(duration: 0.35)) {
                        self.showErrorMessage = true
                    }
                    self.isSubmitButtonClicked = false
                    return
                }
                
                // MARK: Handeling errors
                if let _ = error {
                    self.errorMessage = "Connection Error! 😭"
                    self.errorDescription = "There was a error while connecting to the database. "
                    
                    withAnimation(.spring(duration: 0.35)) {
                        self.showErrorMessage = true
                    }
                    return
                }
                
                for doc in querySnapshot!.documents {
                    let data = doc.data()
                    
                    let adminUsername = data["username"] as! String
                    let adminPassword = data["password"] as! String
                    let adminAdminId = data["adminId"] as! String
                    
                    
                    print(self.username == adminUsername)
                    print(self.password == adminPassword)
                    
                    if self.username == adminUsername && self.password == adminPassword {
                        let adminFullName = data["fullName"] as! String
                        let isAdminSuperAdmin = data["isSuperAdmin"] as! Bool
                        let adminHospitalId = data["hospitalId"] as! String
                        
                        
                        self.admin = .init(adminName: adminFullName, hospitalId: adminHospitalId, asminUsername: adminUsername, password: adminPassword, isSuperAdmin: isAdminSuperAdmin, adminId: adminAdminId)
                        self.isSubmitButtonClicked = false
                        self.showSuccessfullLoginDialog = true
                        return
                    }
                }
                
                self.errorMessage = "Invalid Credentials 🥲"
                self.errorDescription = "Please make sure that that credentials match and are of same ground."
                
                withAnimation(.spring(duration: 0.35)) {
                    self.showErrorMessage = true
                }
                self.isSubmitButtonClicked = false
            }
            return
        }
        
        // MARK: Check if doctor
        if self.isDoctor {
            
            database.collection("doctors").getDocuments() { (snapshot, error) in
                
                // MARK: Handeling errors
                if let _ = error {
                    self.errorMessage = "Connection Error! 😭"
                    self.errorDescription = "There was a error while connecting to the database. "
                    return
                }
                
                for doc in snapshot!.documents {
                    let data = doc.data()
                    
                    let doctorUsername = data["username"] as! String
                    let doctorPassword = data["password"] as! String
                    let doctorId = data["doctorId"] as! String
                    
                    if self.doctorId == doctorId && self.username == doctorUsername && self.password == doctorPassword {
                        self.isSubmitButtonClicked = false
                        self.showSuccessfullLoginDialog = true
                        return
                    }
                }
                
                self.errorMessage = "Invalid Credentials!"
                self.errorDescription = "Please make suer that the doctorId, username and password matches."
                
                withAnimation(.spring(duration: 0.35)) {
                    self.showErrorMessage = true
                }
                return
            }
            
        }
        
        // MARK: IF note doctor and if not admin then user.
        database.collection("users").getDocuments() { (snapshot, error) in
            if let _ = error {
                
            } else {
                for doc in snapshot!.documents {
                    let userData = doc.data()
                    
                    let email = userData["email"] as! String
                    let password = userData["password"] as! String
                    let id = userData["id"] as! String
                    let fullName = userData["fullName"] as! String
                    let phoneNumber = userData["phoneNumber"] as! String
                    let userType = userData["usertype"] as! String
                    let location = userData["location"] as! String
                    
                    
                    if email == self.username && password == self.password {
                        self.isSubmitButtonClicked = false
                        self.user = .init(id: id, fullName: fullName, email: email, location: location, phoneNumber: phoneNumber, userType: userType)
                        self.showSuccessfullLoginDialog = true
                        return
                    }
                }
                
                self.errorMessage = "Invalid Credentials!"
                self.errorDescription = "Email Id or Password my not be correct!"
                withAnimation(.spring(duration: 0.35)) {
                    self.showErrorMessage = true
                }
            }
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
                    //                    ChooseHospitalPage(admin: self.admin)
                    //                        .navigationBarBackButtonHidden()
                    //
                    AdminDashboard(admin: self.$admin)
                        .navigationBarBackButtonHidden()
                }
                
                if self.isDoctor {
                    EmptyView()
                }
                
                if !self.isAdmin && !self.isDoctor && !self.isSuperAdmin {
                    ContentView(user: self.$user)
                        .navigationBarBackButtonHidden()
                }
            }
        }
        
        
    }
}



#Preview {
    RegistrationPage()
}
