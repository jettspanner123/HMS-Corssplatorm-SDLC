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
    
    @EnvironmentObject var appState: AppStates
    
    @State var doctorFullName: String = ""
    @State var username: String = ""
    @State var isSubmitButtonClicked: Bool = false
    var calcPassword: String = generateRandomPassword(length: 10)
    
    @State var doctorHospital: Hospital? = nil
    @State var medicalAcomplishment: String = ""
    @State var speciality: String = ""
    var doctorId: String = UUID().uuidString
    @State var doctorHeight: String = ""
    @State var doctorWeight: String = ""
    @State var doctorPhoneNumber: String = ""
    
    @State var showErrorMessage: Bool = false
    @State var errorMessage: String = "Name Error!"
    @State var errorDescription: String = "Please insure the username is atleast 8 characters long."
    
    @State var showSuccessMessage: Bool = false
    @State var successMessage: String = ""
    
    
    
    func createDoctor() {
        self.isSubmitButtonClicked = true
        
        
        if self.username.isEmpty || self.doctorFullName.isEmpty || self.doctorHospital == nil  || self.speciality.isEmpty  {
            self.errorMessage = "Empty Fields!"
            self.errorDescription = "Please insure that all the required fealds are filled."
            withAnimation {
                self.showErrorMessage = true
            }
            self.isSubmitButtonClicked = false
            return
        }
        
        self.appState.doctors.append(.init(doctorId: self.doctorId, hospitalName: self.doctorHospital!.hospitalName, fullName: self.doctorFullName, username: self.username, password: self.calcPassword, height: NumberFormatter().number(from: self.doctorHeight) as! CGFloat, weight: NumberFormatter().number(from: self.doctorWeight) as! CGFloat, bloodGroup: .op, doctorName: "Dr. \(self.doctorFullName)", hospitalId: self.doctorHospital!.hospitalId, speciality: self.speciality, medicalAcomplishment: self.medicalAcomplishment, phoneNumber: ""))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isSubmitButtonClicked = false
            self.doctorFullName = ""
            self.username = ""
            self.speciality = ""
            self.doctorHeight = ""
            self.doctorWeight = ""
            self.doctorPhoneNumber = ""
            self.doctorHospital = nil
            
            
            self.successMessage = "Doctor Added Successfully!"
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
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                
                // MARK: Error Dialog Box
                
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
                
                
                
                // MARK: Bottom background blur
                HStack {
                }
                .frame(maxWidth: .infinity, minHeight: 100)
                .background(AppBackgroundBlur(radius: 5, opaque: false))
                .offset(y: UIScreen.main.bounds.height - 120)
                .zIndex(9)
                
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
                    self.createDoctor()
                }
                
                
                ScrollView(showsIndicators: false) {
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
                        
                        // MARK: Height text fild
                        CustomTextField(text: self.$doctorHeight, placeholder: "Height")
                            .keyboardType(.decimalPad)
                            .overlay {
                                HStack {
                                    Image(systemName: "figure.stand")
                                        .foregroundStyle(.black.opacity(0.5))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                            }
                        
                        // MARK: Weight text field
                        CustomTextField(text: self.$doctorWeight, placeholder: "Weight")
                            .keyboardType(.decimalPad)
                            .overlay {
                                HStack {
                                    Image(systemName: "scalemass.fill")
                                        .foregroundStyle(.black.opacity(0.5))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                            }
                        
                        CustomTextField(text: self.$doctorPhoneNumber, placeholder: "Phone Number")
                            .keyboardType(.numberPad)
                            .overlay {
                                HStack {
                                    Image(systemName: "phone.fill")
                                        .foregroundStyle(.black.opacity(0.5))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                            }
                        
                        
                        
                        
                        // MARK: Hospital Information Heading
                        SectionHeading(text: "Hospital Information")
                            .padding(.top, 20)
                        
                        // MARK: Hospital Id text field
                        NavigationLink(destination: AssignHospitalPage(hospital: self.$doctorHospital)) {
                            HStack {
                                Text(self.doctorHospital?.hospitalName ?? "None")
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
                        
                        
                        SectionHeading(text: "Id & Password")
                            .padding(.top, 20)
                        
                        
                        HStack {
                            Text(self.calcPassword)
                                .font(.system(size: 15, weight: .regular, design: .rounded))
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
                        
                        // MARK: Doctor id
                        HStack {
                            Text(self.doctorId)
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .lineLimit(1)
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
                                Text("Id")
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundStyle(.black.opacity(0.5))
                                
                                Spacer()
                                
                                Image(systemName: "document.on.clipboard")
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                        .onTapGesture {
                            withAnimation {
                                self.successMessage = "Doctor Id Copied to Clipboard"
                                self.showSuccessMessage = true
                                
                                UIPasteboard.general.string = self.doctorId
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        self.showSuccessMessage = false
                                    }
                                }
                            }
                        }
                        
                        
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(25)
                    .padding(.top, 140)
                    .padding(.bottom, 100)
                    
                    
                    
                }
                .frame(maxWidth: .infinity)
            }
            .background(.gray.opacity(0.2))
            .navigationBarBackButtonHidden()
        }
    }
}

