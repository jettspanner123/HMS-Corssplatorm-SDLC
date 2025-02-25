//
//  CreateHospitalpage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 18/02/25.
//

import SwiftUI
import FirebaseFirestore


struct CreateHospitalPage: View {
    
    @State var showErrorMessage: Bool = false
    @State var errorMessage: String = "Name Error!"
    @State var errorDescription: String = "Please insure the username is atleast 8 characters long."
    @State var isSubmitButtonClicked: Bool = false
    @State var showSecondaryErrorMessage: Bool = false
    
    @State var hospitalName: String = ""
    @State var hospitalLocation: String = ""
    @State var hospitalSpecialisations: Array<String> = []
    @State var currentSpecialisation: String = ""
    @State var hospitalCount: Int = 0
    
    @State var hospitalId: String = ""
    
    func assignHospitalId() {
        let database = Firestore.firestore()
        
        database.collection("registers").getDocuments() { (querySnapshot, error) in
            
            if let _ = error {
                
            }
            
            for doc in querySnapshot!.documents {
                if doc.documentID == "hospitals" {
                    self.hospitalId = "\(doc.data()["count"] as! Int + 1)"
                    self.hospitalCount = doc.data()["count"] as! Int + 1
                }
            }
            
        }
        
    }
    
    @State var showAddSpecialisationField: Bool = false
    
    
    @Environment(\.presentationMode) var presentationMode
    
    func createHospital() -> Void {
        
        self.isSubmitButtonClicked = true
        
        if self.hospitalName.isEmpty || self.hospitalLocation.isEmpty || self.hospitalSpecialisations.isEmpty {
            self.errorMessage = "Every Field Required!"
            self.errorDescription = "Make sure to fill all the required fields correctly."
            self.showErrorMessage = true
            return
        }
        
        
        // MARK: Initiating the database
        let database = Firestore.firestore()
        
        
        // MARK: Uploading the new hospital information
        
        let regex = "\(self.hospitalName.components(separatedBy: .whitespaces).first ?? self.hospitalName)$\(self.hospitalId)#\(Calendar.current.component(.day, from: Date()))_\(Calendar.current.component(.month, from: Date()))_\(Calendar.current.component(.year, from: Date()))"
        let newHospitalRef = database.collection("hospitals").document(regex)
        let newHospitalData = ["hospitalId": regex, "hospitalName": self.hospitalName, "location": self.hospitalLocation, "speciality": self.hospitalSpecialisations.first!, "allSpeciality": self.hospitalSpecialisations] as [String : Any]
        
        newHospitalRef.setData(newHospitalData) { error in
            if let _ = error {
                self.errorMessage = "Server Timeout!"
                self.errorDescription = "Faild to create. Server timout with no responce."
                self.showErrorMessage = true
                
                return
            }
        }
        
        
        self.errorMessage = "Success! 🥳"
        self.errorDescription = ""
        self.showErrorMessage = true
        
        let hospitalCountRef = database.collection("registers").document("hospitals")
        
        hospitalCountRef.setData(["count": self.hospitalCount])
        
        self.isSubmitButtonClicked = false
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            
            
            // MARK: Add Specialisation field Text field
            
            if self.showAddSpecialisationField {
                VStack {
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea()
                .background(.black.opacity(0.75))
                .zIndex(13)
            }
            
            
            // MARK: Bottom background blur
            HStack {
            }
            .frame(maxWidth: .infinity, minHeight: 100)
            .background(AppBackgroundBlur(radius: 5, opaque: false))
            .offset(y: UIScreen.main.bounds.height - 120)
            .zIndex(9)
            
            
            // MARK: Input field for adding specialisaiton
            GeometryReader { dimentions in
                VStack {
                    
                    Spacer()
                        .frame(maxWidth: 1)
                        .frame(height: UIScreen.main.bounds.height * 0.1)
                    
                    SectionHeading(text: "Specialisation Title")
                    
                    CustomTextField(text: self.$currentSpecialisation, placeholder: "Specialisation")
                        .overlay {
                            HStack {
                                Image(systemName: "magnifyingglass")
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 15)
                        }
                    
                    
                    // MARK: Add sepcialisation button
                    HStack {
                        Text("Add")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(.appOrange.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    .padding(.top, 20)
                    .onTapGesture {
                        
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        withAnimation(.smooth(duration: 0.35)) {
                            self.showAddSpecialisationField = false
                            self.hospitalSpecialisations.append(self.currentSpecialisation)
                        }
                        self.currentSpecialisation = ""
                    }
                    
                    
                    // MARK: Cancel button
                    HStack {
                        Text("Cancel")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundStyle(.black.opacity(0.75))
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(.white.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    .onTapGesture {
                        withAnimation(.smooth(duration: 0.35)) {
                            self.showAddSpecialisationField = false
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .bottom)
                .padding(20)
                .background(.appBackground)
                .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 0, bottomLeading: 15, bottomTrailing: 15, topTrailing: 15)))
                .shadow(radius: 1)
                .offset(y: self.showAddSpecialisationField ? -65 : -500)
            }
            .zIndex(21)
            
            // MARK: Error Dialog Box
            if self.showErrorMessage {
                VStack {
                    VStack {
                        Text(self.errorMessage)
                            .font(.system(size: 25, weight: .bold, design: .rounded))
                            .foregroundStyle(.secondary)
                        
                        if !self.errorDescription.isEmpty {
                            Text(self.errorDescription)
                                .padding(.vertical, 20)
                        }
                        
                        HStack {
                            Text(self.errorDescription.isEmpty ? "Okay" : "I Understand")
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
                .zIndex(13)
                
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
                
                Text("Add Hospital")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundStyle(.secondaryAccent)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 50)
            .padding(.bottom, 20)
            .padding(30)
            .zIndex(12)
            
            
            // MARK: Cannot add specialization error
            Text("Cannot add more than 3 specializations")
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .foregroundStyle(.black.opacity(0.5))
                .padding(15)
                .background(.white.gradient)
                .clipShape(Capsule())
                .shadow(radius: 2)
                .offset(y: self.showSecondaryErrorMessage ? UIScreen.main.bounds.height - 225 : UIScreen.main.bounds.height)
                .zIndex(21)
            
            
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
                self.createHospital()
            }
            
            // MARK: Content View
            ScrollView {
                VStack {
                    
                    SectionHeading(text: "Hospital Information")
                        .padding(.horizontal, 25)

                    CustomTextField(text: self.$hospitalName, placeholder: "Name")
                        .overlay {
                            HStack {
                                Image(systemName: "building.columns.fill")
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 15)
                        }
                        .padding(.horizontal, 25)

                    
                    
                    
                    // MARK: Hospital Location text fi
                    CustomTextField(text: self.$hospitalLocation, placeholder: "Address")
                        .overlay {
                            HStack {
                                Image(systemName: "building.columns.fill")
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 15)
                        }
                        .padding(.horizontal, 25)

                    SectionHeading(text: "Hospital Specialization")
                        .padding(.horizontal, 25)
                        .padding(.top, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            
                            // MARK: Add specialisation button
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundStyle(.white)
                                
                                Text("Add")
                                    .foregroundStyle(.white)
                            }
                            .padding(15)
                            .background(.appOrange.gradient)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(radius: 1)
                            .onTapGesture {
                                if self.hospitalSpecialisations.count < 3 {
                                    withAnimation(.smooth(duration: 0.35)) {
                                        self.showAddSpecialisationField = true
                                    }
                                } else {
                                    withAnimation(.smooth(duration: 0.35)) {
                                        self.showSecondaryErrorMessage = true
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        withAnimation(.smooth(duration: 0.35)) {
                                            self.showSecondaryErrorMessage = false
                                        }
                                    }
                                }
                                
                            }
                            
                            
                            
                            ForEach(self.hospitalSpecialisations, id: \.self) { specialisation in
                                Text(specialisation)
                                    .padding(15)
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .shadow(radius: 1)
                            }
                            
                            
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 25)

                    }
                    
                    // MARK: Hospital identification heading
                    SectionHeading(text: "Hospital Identification")
                        .padding(.horizontal, 25)
                        .padding(.top, 20)
                    
                    HStack {
                        Text("\(self.hospitalName.components(separatedBy: .whitespaces).first ?? self.hospitalName)$\(self.hospitalId)#\(Calendar.current.component(.day, from: Date()))_\(Calendar.current.component(.month, from: Date()))_\(Calendar.current.component(.year, from: Date()))")
                            .font(.system(size: 15,weight: .bold ,design: .rounded))
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
                            Image(systemName: "key.fill")
                                .foregroundStyle(.black.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                    }
                    .padding(.horizontal, 25)

                    
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 140)
                
                
            }
            .frame(maxWidth: .infinity)
        }
        .background(.gray.opacity(0.2))
        .onAppear {
            self.assignHospitalId()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CreateHospitalPage()
}
