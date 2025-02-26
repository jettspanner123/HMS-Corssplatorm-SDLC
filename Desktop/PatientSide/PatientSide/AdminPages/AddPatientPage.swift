//
//  AddPatientPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 24/02/25.
//

import SwiftUI

struct AddPatientPage: View {
    
    @State var showErrorMessage: Bool = false
    @State var errorMessage: String = ""
    @State var errorDescription: String = ""
    
    @State var isSubmitButtonClicked: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appStates: AppStates
    
    @State var isGenderOpen: Bool = false
    var genderOptions: Array<String> = ["Chad 🗿", "Gurl 💅🏻", "LGTV 🤡"]
    
    @State var patientFullName: String = ""
    @State var patientId: String = UUID().uuidString
    @State var patientNumber: String = ""
    @State var patientGender: String = "Gender"
    @State var patientAddress: String = ""
    @State var patientGenderSliderValue: Double = 0
    @State var patientBloodGroup: BloodGroup = .select
    
    @State var emergencyContactName: String = ""
    @State var emergencyContactNumber: String = ""
    @State var emergencyContactRelation: String = ""
    @State var emergencyContactAddress: String = ""
    
    @State var showBottomSheet: Bool = false
    @State var bottomSheetTranslation: CGSize = .zero
    
    
    @State var showSuccessMessage: Bool = false
    @State var successMessage: String = ""
    
    let bloodGroupOptions: Array<BloodGroup> = [.ap, .an, .bp, .bn, .abp, .abp, .op]
    
    func setBloodGroup(_ bloodGroup: BloodGroup) {
        self.patientBloodGroup = bloodGroup
        withAnimation(.spring(duration: 0.35)) {
            self.showBottomSheet = false
        }
    }
    
    func createPatient() -> Void {
        
        self.isSubmitButtonClicked = true
        
        if self.patientFullName.isEmpty || self.patientNumber.isEmpty || self.patientGender == "Gender" || self.patientAddress.isEmpty || self.patientBloodGroup == .select || self.emergencyContactName.isEmpty || self.emergencyContactNumber.isEmpty || self.emergencyContactRelation.isEmpty || self.emergencyContactAddress.isEmpty {
            self.errorMessage = "All Fields Requred 🥲"
            self.errorDescription = "Make sure that all the fields are filled properly."
            self.isSubmitButtonClicked = false
            withAnimation {
                self.showErrorMessage = true
            }
            return
        }
        
        self.appStates.users.append(.init(id: self.patientId, fullName: self.patientFullName, email: "", location: self.patientAddress, phoneNumber: self.patientNumber, userType: "patient"))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isSubmitButtonClicked = false
            self.patientFullName = ""
            self.patientNumber = ""
            self.patientGender = "Gender"
            self.patientAddress = ""
            self.patientBloodGroup = .select
            
            self.emergencyContactName = ""
            self.emergencyContactNumber = ""
            self.emergencyContactAddress = ""
            self.emergencyContactRelation = ""
            
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
        ZStack(alignment: .top) {
            
            
            // MARK: Dark backdrop
            if self.showBottomSheet {
                Color.black.opacity(0.75)
                    .ignoresSafeArea()
                    .zIndex(20)
                    .onTapGesture {
                        withAnimation(.spring(duration: 0.35)) {
                            self.showBottomSheet = false
                            
                        }
                        
                    }
            }
            
            
            // MARK: Bottom sheet
            if self.showBottomSheet {
                VStack {
                    VStack {
                        
                        Capsule()
                            .fill(.appOrange.opacity(0.25))
                            .stroke(.black.opacity(0.5), lineWidth: 0.5)
                            .frame(maxWidth: 50, maxHeight: 15)
                        
                        
                        // MARK: Bottom sheet headign
                        Text("Blood Group")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundStyle(.secondaryAccent)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 20)
                        
                        
                        
                        
                            
                            // MARK: Blood group list
                            VStack(spacing: 0) {
                                
                                ForEach(self.bloodGroupOptions, id: \.self) { bloodGroup in
                                    InformationListItem(key: bloodGroup.rawValue, value: "")
                                        .onTapGesture {
                                            self.setBloodGroup(bloodGroup)
                                        }
                                    
                                    CustomDivider()
                                }
                                
                                InformationListItem(key: "O-", value: "")
                                    .onTapGesture {
                                        self.setBloodGroup(.on)
                                    }
                               
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 10)
                            .background(.white.gradient)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(radius: 1)
                        
                        
                        Spacer()
                            .frame(maxWidth: .infinity, maxHeight: 30)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(25)
                    .background(.appBackground)
                    .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 15, topTrailing: 15)))
                    .offset(y: self.bottomSheetTranslation.height)
                    .edgesIgnoringSafeArea(.bottom)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if value.translation.height > .zero {
                                    withAnimation(.bouncy) {
                                        self.bottomSheetTranslation = value.translation
                                    }
                                }
                            }
                            .onEnded { value in
                                if value.translation.height > 100 {
                                    withAnimation(.spring(duration: 0.35)) {
                                        self.showBottomSheet = false
                                        self.bottomSheetTranslation = .zero
                                    }
                                } else {
                                    withAnimation(.spring(duration: 0.35)) {
                                        self.bottomSheetTranslation = .zero
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
            
            
            
            
            // MARK: Bottom background blur
            HStack {
            }
            .frame(maxWidth: .infinity, minHeight: 100)
            .background(AppBackgroundBlur(radius: 5, opaque: false))
            .offset(y: UIScreen.main.bounds.height - 120)
            .zIndex(9)
            
            
            
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
                
                Text("Add Patient")
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
                self.createPatient()
            }
            
            
            
            ScrollView(showsIndicators: false) {
                VStack {
                    
                    
                    
                    
                    // MARK: Public information heding
                    SectionHeading(text: "Public Information")
                    
                    // MARK: Full name text field
                    CustomTextField(text: self.$patientFullName, placeholder: "Full Name")
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
                    
                    CustomTextField(text: self.$patientNumber, placeholder: "Phone Number")
                        .overlay {
                            HStack {
                                Text("91")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                    
                    HStack {
                        Text(self.patientId.prefix(10))
                            .font(.system(size: 16, weight: .regular, design: .rounded))
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
                            Text("Id")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .foregroundStyle(.black.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                    }
                    
                    
                    // MARK: Gender mask
                    VStack {
                        
                        // MARK: The stack with the gender and options button
                        HStack {
                            Text(self.patientGender)
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                                .foregroundStyle(.black.opacity(0.5))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 55)
                                .overlay {
                                    HStack {
                                        Image(systemName: "person.wave.2")
                                            .foregroundStyle(.black.opacity(0.5))
                                        
                                        Spacer()
                                        
                                        Image(systemName: "ellipsis")
                                            .foregroundStyle(.black.opacity(0.5))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 15)
                                }
                            
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        // MARK: Gender options
                        if self.isGenderOpen {
                            HStack {
                                ForEach(self.genderOptions, id: \.self) { gender in
                                    Text(gender)
                                        .font(.system(size: 13, weight: .regular, design: .rounded))
                                        .foregroundStyle(self.patientGender == gender ? .white : .black)
                                        .padding(10)
                                        .background(self.patientGender == gender ? .appOrange : .gray.opacity(0.12))
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        .shadow(radius: 1)
                                        .onTapGesture {
                                            withAnimation(.smooth(duration: 0.2)) {
                                                self.patientGender = gender
                                                self.isGenderOpen = false
                                            }
                                        }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 25)
                            .padding(.vertical, 5)
                            
                            Text("Prefet Not Say 🗿")
                                .font(.system(size: 13, weight: .regular, design: .rounded))
                                .foregroundStyle(self.patientGender == "Prefet Not Say 🗿" ? .white : .black)
                                .padding(10)
                                .background(self.patientGender == "Prefet Not Say 🗿" ? .appOrange : .gray.opacity(0.12))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .shadow(radius: 1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 25)
                                .onTapGesture {
                                    withAnimation(.smooth(duration: 0.2)) {
                                        self.patientGender = "Prefet Not Say 🗿"
                                        self.isGenderOpen = false
                                    }
                                }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .frame(height: self.isGenderOpen ? 155 : 55)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    .onTapGesture {
                        withAnimation(.smooth(duration: 0.2)) {
                            self.isGenderOpen.toggle()
                        }
                    }
                    
                    
                   
                    
                    
                    
                    
                    if self.patientGender == "LGTV 🤡" {
                        
                        SectionHeading(text: "Gender Slider")
                            .padding(.top, 20)
                        
                        VStack {
                            Slider(value: self.$patientGenderSliderValue, in: 1...100, step: 1)
                                .tint(.appOrange)
                            
                            HStack {
                                Text("Male")
                                    .frame(maxWidth: 75)
                                    .padding(10)
                                    .background(.white.gradient)
                                    .clipShape(Capsule())
                                    .shadow(radius: 1)
                                
                                Spacer()
                                
                                Text(String(format: "%.0f", self.patientGenderSliderValue) + "%")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .frame(maxWidth: 70)
                                    .background(
                                        LinearGradient(gradient: Gradient(colors: [.indigo.opacity(0.7), .blue.opacity(0.7), .green.opacity(0.7), .yellow.opacity(0.7), .orange.opacity(0.7), .red.opacity(0.7)] ), startPoint: .leading, endPoint: .trailing)
                                    )
                                    .clipShape(Capsule())
                                    .shadow(radius: 1)
                                
                                
                                Spacer()
                                Text("Female")
                                    .frame(maxWidth: 75)
                                    .padding(10)
                                    .background(.white.gradient)
                                    .clipShape(Capsule())
                                    .shadow(radius: 1)
                                
                            }
                        }
                        .padding(.horizontal, 15)
                        
                        Text("Use the slider to specify the percentage of what you feel like you are, male and female being the two ends of the spectrum.")
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.black.opacity(0.5))
                            .padding(.horizontal, 15)
                            .padding(.top, 10)
                    }
                    
                    
                    CustomTextField(text: self.$patientAddress, placeholder: "Address")
                        .overlay {
                            HStack {
                                Image(systemName: "house.fill")
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 15)
                        }
                   
                    
                     
                    // MARK: Patient Blood group
                    HStack {
                        Text(self.patientBloodGroup.rawValue)
                            .font(.system(size: 17, weight: .regular, design: .rounded))
                            .foregroundStyle(.black.opacity(0.5))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .padding(.horizontal, 52)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    .onTapGesture {
                        withAnimation {
                            self.showBottomSheet = true
                        }
                    }
                    .overlay {
                        HStack {
                            Image(systemName: "drop.fill")
                                .foregroundStyle(.black.opacity(0.5))
                            
                            Spacer()
                            
                            Image(systemName: "ellipsis")
                                .foregroundStyle(.black.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                    }
                    
                    
                    
                    // MARK: Emergency contact something
                    SectionHeading(text: "Emergency Contact")
                        .padding(.top, 20)
                    
                    
                    CustomTextField(text: self.$emergencyContactName, placeholder: "Full Name")
                        .overlay {
                            HStack {
                                Text("Ab")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 15)
                        }
                    
                    CustomTextField(text: self.$emergencyContactNumber, placeholder: "Number")
                        .overlay {
                            HStack {
                                Image(systemName: "exclamationmark.circle.fill")
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 15)
                        }
                    
                    CustomTextField(text: self.$emergencyContactRelation, placeholder: "Relation")
                        .overlay {
                            HStack {
                                Image(systemName: "person.2.fill")
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 15)
                        }
                    
                    CustomTextField(text: self.$emergencyContactAddress, placeholder: "Address")
                        .overlay {
                            HStack {
                                Image(systemName: "house.fill")
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 15)
                        }
                    
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 160)
                .padding(.horizontal, 25)
            }
            .background(.gray.opacity(0.2))
        }
        .navigationBarBackButtonHidden()
        
    }
}

#Preview {
    AddPatientPage()
}
