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
    @State var adminId: String = ""
    
    @State var errorMessage: String = "Account Not Found"
    @State var errorDescription: String = "The account you are trying to enter either dosen't exist or has a different password."
    @State var showErrorMessage: Bool = false
    
    @State var showSuccessfullLoginDialog: Bool = false
    
    @State var isPasswordHidden: Bool = false
    @State var isSubmitButtonClicked: Bool = false
    
    @State var isDoctor: Bool = false
    @State var isAdmin: Bool = false
    
    @State var user: SendUser = .init(id: "", fullName: "", email: "", location: "", phoneNumber: "", userType: "")
    
    
    // MARK: Function jisse kuch ho raha hai
    func performLogin() -> Void {
        self.isSubmitButtonClicked = true
        
        
        let database = Firestore.firestore()
        
        
        if self.isAdmin {
            self.showSuccessfullLoginDialog = true
            return
        }
        
        
        if self.isDoctor {
        }
        
        database.collection("users").getDocuments() { (snapshot, error) in
            if let error = error {
                
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
                self.showErrorMessage = true
            }
        }
        
        print((self.username, self.password))
        
        self.isSubmitButtonClicked = false
    }
    
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
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                
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
                                self.showErrorMessage = false
                            }
                            
                        }
                        .padding(30)
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .clipShape(.rect(cornerRadius: 14))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(25)
                    .background(.black.opacity(0.5))
                    .shadow(radius: 1)
                    .zIndex(12)
                    
                }
                
                
                VStack {
                    // MARK: Profile heading
                    if !self.isDoctor && !self.isAdmin {
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
                        
                        Text(self.isDoctor ? "Doctor" : self.isAdmin ? "Admin" : "")
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
                        .clipped()
                        .onTapGesture {
                            self.isPasswordHidden.toggle()
                        }
                        .offset(x: self.isPasswordHidden ? 144 : 140)
                        
                    }
                    .padding(.top, 3)
                    
                    
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
                .padding(30)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(.gray.opacity(0.2))
            }
            .navigationDestination(isPresented: self.$showSuccessfullLoginDialog) {
                if self.isAdmin {
                    AddDoctorPage()
                        .navigationBarBackButtonHidden()
                    
                    
                }
                if !self.isAdmin && !self.isDoctor {
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
