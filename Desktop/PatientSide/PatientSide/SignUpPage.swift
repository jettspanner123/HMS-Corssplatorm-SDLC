//
//  SignUpPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 13/02/25.
//

import SwiftUI
import FirebaseFirestore

struct SignUpPage: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var fullName: String = ""
    @State var phoneNumber: String = ""
    @State var location: String = ""
    
    
    @State var isPasswordHidden: Bool = false
    @State var isPasswordConfirmHidden: Bool = false
    @State var isSubmitButtonClicked: Bool = false
    
    @State var showErrorMessage: Bool = false
    @State var errorMessage: String = "Name Error!"
    @State var errorDescription: String = "Please insure the username is atleast 8 characters long."
    
    @State var isPageChanged: Bool = false
    
    @State var user: SendUser = .init(id: "", fullName: "", email: "", location: "", phoneNumber: "", userType: "")
    
    
    // MARK: Peform signup backend function
    
    private func performSignup() -> Void {
        
        self.isSubmitButtonClicked = true
        
        if self.email.isEmpty || self.fullName.isEmpty || self.password.isEmpty || self.confirmPassword.isEmpty || self.phoneNumber.isEmpty || self.location.isEmpty {
            self.errorMessage = "Empty Fields!"
            self.errorDescription = "Please insure that all the required fealds are filled."
            self.showErrorMessage = true
            return
        }
        
        if !self.email.contains("@") || !self.email.contains(".") {
            self.errorMessage = "Email Not Valid!"
            self.errorDescription = "Please insure that the email id is valid."
            self.showErrorMessage = true
            return
        }
        
        if self.fullName.isEmpty || self.fullName.count < 8 {
            self.errorMessage = "Name Error!"
            self.errorDescription = "Please insure the name is atleast 8 characters long."
            self.showErrorMessage = true
            return
        }
        
        
        
        if self.password != self.confirmPassword {
            self.errorMessage = "Incorrect Password"
            self.errorDescription = "Make sure the Password and Confirm Password are the same."
            self.showErrorMessage = true
            return
        }
        
        
        print("Firebase started")
        
        
        let database = Firestore.firestore()
        let userId = UUID().uuidString
        let addUserReference = database.collection("users").document(userId)
        
        let userData = ["id": userId, "fullName": self.fullName, "email": self.email, "password": self.password, "phoneNumber": self.phoneNumber, "location": self.location, "usertype": "patient"] as [String : Any]
        self.user = .init(id: userId, fullName: self.fullName, email: self.email, location: self.location, phoneNumber: self.phoneNumber, userType: "patient")
        
        addUserReference.setData(userData) { error in
            if let _ = error {
                self.errorMessage = "Error Occured!"
                self.errorDescription = "Servers busy at the moment! Please try again later."
                self.showErrorMessage = true
            } else {
                self.isSubmitButtonClicked = false
                self.isPageChanged = true
                print("Firebase Ended")
            }
        }
        
        
        
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                
                
                
                // MARK: Error message box hai
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
                                self.isSubmitButtonClicked = false
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
                
                // MARK: Bottom background blur
                HStack {
                }
                .frame(maxWidth: .infinity, minHeight: 100)
                .background(AppBackgroundBlur(radius: 5, opaque: false))
                .offset(y: UIScreen.main.bounds.height - 120)
                .zIndex(9)
                
                
                // MARK: Top background blur
                HStack {
                }
                .frame(maxWidth: .infinity)
                .frame(height: 220)
                .background(
                    AppBackgroundBlur(radius: 20, opaque: false)
                )
                .offset(y: -70)
                .zIndex(11)
                
               
                
                HStack(spacing: 15) {
                    
                    HStack {
                        Image(systemName: "arrow.left")
                    }
                    .frame(maxWidth: 45, maxHeight: 45)
                    .background(.white)
                    .clipShape(Circle())
                    .shadow(radius: 1)
                    
                    
                    
                    Text("Sign Up")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundStyle(.secondaryAccent)
                   
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 50)
                .padding(.bottom, 20)
                .padding(30)
                .zIndex(12)
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
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
                .padding(.horizontal, 30)
                .offset(y: UIScreen.main.bounds.height - 145)
                .zIndex(10)
                .onTapGesture {
                    self.performSignup()
                }
                
                
                ScrollView(showsIndicators: false) {
                    
                    
                    VStack {
                        
                        
                        SectionHeading(text: "Social Information")
                            .padding(.top, 20)
                        
                        CustomTextField(text: self.$email, placeholder: "Email Id")
                            .autocapitalization(.none)
                            .overlay {
                                Image(systemName: "at")
                                    .offset(x: -UIScreen.main.bounds.width / 2 + 60)
                                    .foregroundStyle(.secondaryAccent)
                            }
                        CustomTextField(text: self.$fullName, placeholder: "Full Name")
                            .autocapitalization(.none)
                            .overlay {
                                Text("A")
                                    .font(.system(size: 20, weight: .medium, design: .rounded))
                                    .foregroundStyle(.secondaryAccent)
                                    .offset(x: -UIScreen.main.bounds.width / 2 + 60)
                            }
                        
                        SectionHeading(text: "Personal Information")
                            .padding(.top, 20)
                        
                        CustomTextField(text: self.$phoneNumber, placeholder: "Phone Number")
                            .autocapitalization(.none)
                            .overlay {
                                Image(systemName: "phone.fill")
                                    .offset(x: -UIScreen.main.bounds.width / 2 + 60)
                            }
                        
                        CustomTextField(text: self.$location, placeholder: "Nearest Location")
                            .autocapitalization(.none)
                            .overlay {
                                Image(systemName: "mappin.and.ellipse")
                                    .offset(x: -UIScreen.main.bounds.width / 2 + 60)
                            }
                        
                        SectionHeading(text: "Account Password")
                            .padding(.top, 20)
                        
                        
                        
                        // MARK: Password filed
                        ZStack {
                            if self.isPasswordHidden {
                                TextField("Password", text: $password, prompt: Text("Password").foregroundStyle(.black.opacity(0.5)))
                                    .autocapitalization(.none)
                                    .frame(height: 55)
                                    .padding(.horizontal,55)
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
                            } else {
                                SecureField("Password", text: $password, prompt: Text("Password").foregroundStyle(.black.opacity(0.5)))
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
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.horizontal, 20)
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
                        
                        // MARK: Confirm Password field
                        ZStack {
                            
                            if self.isPasswordConfirmHidden {
                                TextField("Password", text: self.$confirmPassword, prompt: Text("Confirm Password").foregroundStyle(.black.opacity(0.5)))
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
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.horizontal, 20)
                                    }
                            } else {
                                SecureField("Password", text: self.$confirmPassword, prompt: Text("Confirm Password").foregroundStyle(.black.opacity(0.5)))
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
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.horizontal, 20)
                                    }
                            }
                            
                            
                            HStack {
                                Image(systemName: self.isPasswordConfirmHidden ? "lock.open" : "lock")
                            }
                            .frame(maxWidth: 50, maxHeight: 50)
                            .clipped()
                            .onTapGesture {
                                self.isPasswordConfirmHidden.toggle()
                            }
                            .offset(x: self.isPasswordConfirmHidden ? 144 : 140)
                            
                        }
                        
                    }
                    .padding(30)
                    .padding(.top, 120)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .padding(.bottom, 200)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.gray.opacity(0.2))
            .navigationDestination(isPresented: self.$isPageChanged) {
                ContentView(user: self.$user)
                    .navigationBarBackButtonHidden()
            }
        }
        
        
    }
}



#Preview {
    SignUpPage()
}
