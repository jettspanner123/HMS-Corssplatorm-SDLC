//
//  SearchPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 17/02/25.
//

import SwiftUI
import FirebaseFirestore

struct SearchPage: View {
    
    //    @Binding var showSettingPage: Bool
    
    @State var searchText: String = ""
    @State var isSearching: Bool = false
    @State var currentSelectedFilter: String = "Doctors"
    var filterOptions: Array<String> = ["All", "Doctors", "Hospitals", "Clinics"]
    
    
    @Binding var user: SendUser
    
    var body: some View {
        ZStack(alignment: .top) {
            
            // MARK: Page header
            
            if !self.isSearching {
                PageHeader_t(text: "Search")
                    .zIndex(12)
            }
           
            // MARK: Content view
            ScrollView(showsIndicators: false) {
                VStack {
                    
                    // MARK: Search box
                    CustomTextField(text: self.$searchText, placeholder: "Search")
                        .onChange(of: self.searchText) { newValue in
                            
                            withAnimation(.smooth(duration: 0.2)) {
                                self.isSearching = true
                            }
                            
                            if self.searchText.isEmpty {
                                withAnimation(.smooth(duration: 0.2)) {
                                    self.isSearching = false
                                }
                            }
                            
                        }
                        .overlay {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(.black.opacity(0.5))
                                
                                Spacer()
                                
                                if !self.searchText.isEmpty {
                                    HStack {
                                        Image(systemName: "xmark")
                                            .foregroundStyle(.black.opacity(0.5))
                                    }
                                    .frame(width: 45, height: 45)
                                    .offset(x: 20)
                                    .onTapGesture {
                                        withAnimation(.smooth(duration: 0.2)) {
                                            self.isSearching = false
                                            self.searchText = ""
                                        }
                                    }
                                }
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                    
                    
                    // MARK: Doctor's heading
                    SectionHeading(text: "Doctors")
                        .padding(.top, 20)
                    
                }
                .padding(.horizontal, 25)
                .padding(.vertical, self.isSearching ? 20 : 80)
            }
            
            
            // MARK: Blur at the background of tab bar
            HStack {
                
            }
            .frame(maxWidth: .infinity, minHeight: 100)
            .background(AppBackgroundBlur(radius: 10, opaque: false))
            .offset(y: UIScreen.main.bounds.height - 140)
            
        }
    }
}

struct DoctorFilterView: View {
    
    @State var doctors: Array<Doctor> = []
    
    
    
    // MARK: Fetch doctors only
    func fetchDoctors() {
        
        let database = Firestore.firestore()
        database.collection("doctors").getDocuments() { (snapshot, error) in
            if let _ = error {
                
            }
            
            
            self.doctors = snapshot!.documents.compactMap { doc in
                let data = doc.data()
                let id = doc.documentID
                
                let fullName = data["fullName"] as! String
                let username = data["username"] as! String
                let password = data["password"] as! String
                let hospitalId =  data["hospitalId"] as! String
                let hospitalName = data["hospitalName"] as! String
                let medicalAcomplishment = data["medicalAcomplishment"] as! String
                let speciality = data["speciality"] as! String
                
                return Doctor(doctorId: id, hospitalName: hospitalName, fullName: fullName, username: username, password: password,height: 183, weight: 89, bloodGroup: .ap ,doctorName: fullName, hospitalId: hospitalId, speciality: speciality, medicalAcomplishment: medicalAcomplishment)
            }
            
        }
    }
    
    var body: some View {
        VStack {
            SectionHeading(text: "Doctors")
            ForEach(self.doctors, id: \.self) { doctor in
                DoctorCard(doctor: doctor)
            }
        }
        .onAppear {
            self.fetchDoctors()
        }
    }
}

struct HospitalFilterView: View {
    
    @State var hospitals: Array<Hospital> = []
    
    func fetchHospitals() {
        
        
        let database = Firestore.firestore()
        database.collection("hospitals").getDocuments() { (snapshot, error) in
            if let _ = error {
                
            }
            
            self.hospitals = snapshot?.documents.compactMap { doc in
                let data = doc.data()
                let id = doc.documentID
                
                let name = data["hospitalName"] as? String
                let superadminId = data["superadminId"] as? String
                let location = data["location"] as? String
                let speciality = data["speciality"] as? String
                
                return Hospital(hospitalId: id, hospitalName: name ?? "Neelam", superadminId: superadminId ?? "", location: location ?? "Patiala, Punjab", speciality: speciality ?? "Radiology")
                
                
            } ?? []
            
        }
        
    }
    var body: some View {
        VStack {
            SectionHeading(text: "Hospitals")
            
            ForEach(self.$hospitals, id: \.self) { hospital in
                HospitalCard(hospital: hospital)
            }
        }
        .onAppear {
            self.fetchHospitals()
        }
    }
}

struct ClinicsFilterView: View {
    var body: some View {
        VStack {
            
        }
    }
}



struct AllFilterView: View {
    
    let database = Firestore.firestore()
    
    @State private var isLoading: Bool = false
    @State var hospitals: Array<Hospital> = []
    @State var doctors: Array<Doctor> = []
    
    
    
    // MARK: Fetch hospital and doctors section
    func fetchHospitals() {
        
        
        self.isLoading = true
        let database = Firestore.firestore()
        
        database.collection("hospitals").getDocuments() { (snapshot, error) in
            if let _ = error {
                
            }
            
            self.hospitals = snapshot?.documents.compactMap { doc in
                let data = doc.data()
                let id = doc.documentID
                
                let name = data["hospitalName"] as? String
                let superadminId = data["superadminId"] as? String
                let location = data["location"] as? String
                let speciality = data["speciality"] as? String
                
                return Hospital(hospitalId: id, hospitalName: name ?? "Neelam", superadminId: superadminId ?? "", location: location ?? "Patiala, Punjab", speciality: speciality ?? "Radiology")
                
                
            } ?? []
            
        }
        
        
        database.collection("doctors").getDocuments() { (snapshot, error) in
            if let _ = error {
                
            }
            
            
            self.doctors = snapshot!.documents.compactMap { doc in
                let data = doc.data()
                let id = doc.documentID
                
                let fullName = data["fullName"] as! String
                let username = data["username"] as! String
                let password = data["password"] as! String
                let hospitalId =  data["hospitalId"] as! String
                let hospitalName = data["hospitalName"] as! String
                let medicalAcomplishment = data["medicalAcomplishment"] as! String
                let speciality = data["speciality"] as! String
                
                return Doctor(doctorId: id, hospitalName: hospitalName, fullName: fullName, username: username, password: password,height: 183, weight: 89, bloodGroup: .ap ,doctorName: fullName, hospitalId: hospitalId, speciality: speciality, medicalAcomplishment: medicalAcomplishment)
            }
            
        }
        
        self.isLoading = false
    }
    
    var body: some View {
        VStack(spacing: 10) {
            if self.isLoading {
                ProgressView()
                    .tint(.appOrange)
            } else {
                
                // MARK: Hospital section heading
                SectionHeading(text: "Hospitals")
                ForEach(self.$hospitals, id: \.self) { $hospital in
                    NavigationLink(destination: HospitalScreen(hospital: $hospital)) {
                        HospitalCard(hospital: $hospital)
                    }
                }
                
                SectionHeading(text: "Doctors")
                    .padding(.top, 20)
                
                ForEach(self.doctors, id: \.self) { doctor in
                    NavigationLink(destination: EmptyView()) {
                        DoctorCard(doctor: doctor)
                    }
                }
            }
            
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            self.fetchHospitals()
        }
    }
}


// MARK: Hospital View Card

struct HospitalCard: View {
    @Binding var hospital: Hospital
    
    var body: some View {
        HStack(spacing: 15) {
            
            
            // MARK: Hospital Image
            HStack {
                Image("hospital")
                    .resizable()
            }
            .frame(maxWidth: 100, maxHeight: 120)
            .background(.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(radius: 1)
            
            
            // MARK: Hospital Information
            VStack {
                Text(self.hospital.hospitalName)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .lineLimit(1)
                    .foregroundStyle(.black.opacity(0.5))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(self.hospital.location)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.secondaryAccent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Text(self.hospital.speciality)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.secondaryAccent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.vertical, 10)
            
            Spacer()
            
            // MARK: Navigation arrow
            HStack(alignment: .top) {
                Image(systemName: "plus")
                    .foregroundStyle(.secondaryAccent)
            }
            .frame(maxHeight: .infinity)
            .padding(.trailing, 10)
            
        }
        .frame(maxWidth: .infinity, maxHeight: 100, alignment: .leading)
        .padding(10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 1)
    }
}

// MARK: Doctor View Crd

struct DoctorCard: View {
    var doctor: Doctor
    
    var body: some View {
        HStack {
            
            HStack {
                Image(systemName: "person.fill")
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: 60, maxHeight: 60)
            .background(.appOrange.gradient)
            .clipShape(Circle())
            .shadow(radius: 1)
            
            
            VStack {
                Text(self.doctor.doctorName)
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundStyle(.black.opacity(0.5))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(self.doctor.speciality + " (" + self.doctor.hospitalName + ") ")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundStyle(.black.opacity(0.5))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.vertical, 10)
            
            Spacer()
            
            // MARK: Navigation arrow
            HStack(alignment: .top) {
                Image(systemName: "arrow.right")
                    .foregroundStyle(.secondaryAccent)
            }
            .frame(maxHeight: .infinity)
            .padding(.trailing, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: 100, alignment: .leading)
        .padding(10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 1)
    }
}


#Preview {
    SearchPage(user: .constant(.init(id: "", fullName: "", email: "", location: "", phoneNumber: "", userType: "")))
}
