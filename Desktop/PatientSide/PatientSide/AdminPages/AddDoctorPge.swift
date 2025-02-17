//
//  AddDoctorPge.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 17/02/25.
//

import SwiftUI
import FirebaseFirestore

func generateRandomPassword(length: Int = 10) -> String {
    let allowedCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()"
    let allowedCharactersCount = UInt32(allowedCharacters.count)
    
    var password = ""
    for _ in 0..<length {
        let randomNum = arc4random_uniform(allowedCharactersCount)
        let randomIndex = allowedCharacters.index(allowedCharacters.startIndex, offsetBy: Int(randomNum))
        let randomCharacter = allowedCharacters[randomIndex]
        password.append(randomCharacter)
    }
    return password
}

struct AddDoctorPage: View {
    
    
    
    @State var doctorFullName: String = ""
    @State var username: String = ""
    @State var isSubmitButtonClicked: Bool = false
    var calcPassword: String = generateRandomPassword(length: 10)
    @State var hospitalId: String = ""
    @State var medicalAcomplishment: String = ""
    @State var speciality: String = ""
    @State var hospitalName: String = ""
    
    @State var showErrorMessage: Bool = false
    @State var errorMessage: String = "Name Error!"
    @State var errorDescription: String = "Please insure the username is atleast 8 characters long."
    
    
    
    func createDoctor() {
        self.isSubmitButtonClicked = true
        
        
        if self.username.isEmpty || self.doctorFullName.isEmpty || self.hospitalId.isEmpty || self.hospitalName.isEmpty || self.speciality.isEmpty  {
            self.errorMessage = "Empty Fields!"
            self.errorDescription = "Please insure that all the required fealds are filled."
            self.showErrorMessage = true
            return
        }
        
        let database = Firestore.firestore()
        let doctorId = UUID().uuidString
        
        let docRef = database.collection("doctors").document(doctorId)
        let doctor = ["fullName": self.doctorFullName, "hospitalId": self.hospitalId, "hospitalName": self.hospitalName, "medicalAcomplishment": self.medicalAcomplishment, "password": self.calcPassword, "speciality": self.speciality, "username": self.username]
        
        docRef.setData(doctor){ error in
            if let _ = error {
                self.errorMessage = "Requerst Timeout!"
                self.errorDescription = "Server coult not respont. Try again later."
                self.showErrorMessage = true
                return
            }
        }
        
        self.errorMessage = "Addition Successful!"
        self.errorDescription = "Doctor is added successfully to the database!"
        self.showErrorMessage = true
        
        self.isSubmitButtonClicked = false
        
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .top) {
            
            
            // MARK: Error Dialog Box
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
                    Image(systemName: "xmark")
                }
                .frame(maxWidth: 45, maxHeight: 45)
                .background(.white)
                .clipShape(Circle())
                .shadow(radius: 1)
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
                
                Text("Add Doctor")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundStyle(.secondaryAccent)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 50)
            .padding(.bottom, 20)
            .padding(30)
            .zIndex(12)
            .onTapGesture {
            }
            
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
            .offset(y: UIScreen.main.bounds.height - 180)
            .zIndex(10)
            .onTapGesture {
                self.createDoctor()
            }
            
            
            ScrollView {
                VStack {
                    
                    // MARK: Public information heding
                    SectionHeading(text: "Public Information")
                    
                    // MARK: Full name text field
                    CustomTextField(text: self.$doctorFullName, placeholder: "Full Name")
                        .autocapitalization(.none)
                        .overlay {
                            HStack {
                                Text("Ab")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                    
                    // MARK: Username text field
                    CustomTextField(text: self.$username, placeholder: "Username")
                    
                        .autocapitalization(.none)
                        .overlay {
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                    
                    
                    // MARK: Speciality text field
                    CustomTextField(text: self.$speciality, placeholder: "Speciality")
                    
                        .autocapitalization(.none)
                        .overlay {
                            HStack {
                                Image(systemName: "hand.raised.fill")
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                    
                    
                    
                    // MARK: Hospital Information Heading
                    SectionHeading(text: "Hospital Information")
                        .padding(.top, 20)
                    
                    // MARK: Hospital Id text field
                    CustomTextField(text: self.$hospitalId, placeholder: "Hospital Id")
                    
                        .autocapitalization(.none)
                        .overlay {
                            HStack {
                                Image(systemName: "building.columns.fill")
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                    
                    
                    // MARK: Hospital Name
                    CustomTextField(text: self.$hospitalName, placeholder: "Hospital Name")
                    
                        .autocapitalization(.none)
                        .overlay {
                            HStack {
                                Image(systemName: "text.cursor")
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                    
                    
                    SectionHeading(text: "Password")
                        .padding(.top, 20)
                    
                    
                    HStack {
                        Text(self.calcPassword)
                            .foregroundStyle(.black.opacity(0.5))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 55)
                    .frame(height: 55)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    .overlay {
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundStyle(.black.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(30)
                .padding(.top, 140)
                
                
            }
            .frame(maxWidth: .infinity)
        }
        .background(.gray.opacity(0.2))
    }
}

#Preview {
    AddDoctorPage()
}
