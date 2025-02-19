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
    
    @State var hospitalName: String = ""
    @State var hospitalLocation: String = ""
    @State var hospitalSpecialisations: Array<String> = ["Neurology"]
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
                                self.showAddSpecialisationField = false
                                withAnimation {
                                    self.hospitalSpecialisations.append(self.currentSpecialisation)
                                }
                            }
                            
                            
                            // MARK: Cancel button
                            HStack {
                                Text("Cancle")
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundStyle(.black.opacity(0.75))
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(.white.gradient)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(radius: 1)
                            .onTapGesture {
                                self.showAddSpecialisationField = false
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .bottom)
                        .padding(20)
                        .background(.appBackground)
                        .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 0, bottomLeading: 15, bottomTrailing: 15, topTrailing: 15)))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea()
                .background(.black.opacity(0.5))
                .zIndex(13)
            }
            
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
                    Image(systemName: "xmark")
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
            .offset(y: UIScreen.main.bounds.height - 180)
            .zIndex(10)
            .onTapGesture {
                self.createHospital()
            }
            
            // MARK: Content View
            ScrollView {
                VStack {
                    
                    SectionHeading(text: "Hospital Information")
                    
                    CustomTextField(text: self.$hospitalName, placeholder: "Name")
                        .overlay {
                            HStack {
                                Image(systemName: "building.columns.fill")
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 15)
                        }
                    
                    
                    
                    
                    
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
                    
                    SectionHeading(text: "Hospital Specialization")
                        .padding(.top, 20)
                    
                    HStack {
                        
                        // MARK: Add specialisation button
                        HStack() {
                            Image(systemName: "plus.circle.fill")
                                .foregroundStyle(.white)
                            
                            Text("Add")
                                .foregroundStyle(.white)
                        }
                        .padding(10)
                        .background(.appOrange.gradient)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                        .onTapGesture {
                            self.showAddSpecialisationField = true
                        }
                        
                        
                        
                        ForEach(self.hospitalSpecialisations, id: \.self) { specialisation in
                            Text(specialisation)
                                .padding(10)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .shadow(radius: 1)
                        }
                        
                        
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // MARK: Hospital identification heading
                    SectionHeading(text: "Hospital Identification")
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
                    
                }
                .frame(maxWidth: .infinity)
                .padding(25)
                .padding(.top, 140)
                
                
            }
            .frame(maxWidth: .infinity)
        }
        .background(.appBackground)
        .onAppear {
            self.assignHospitalId()
        }
    }
}

#Preview {
    CreateHospitalPage()
}
