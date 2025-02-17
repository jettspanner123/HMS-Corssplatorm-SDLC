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
    @State var currentSelectedFilter: String = "All"
    var filterOptions: Array<String> = ["All", "Doctors", "Hospitals", "Clinics"]
    
    
    @Binding var user: SendUser
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    Text("Search")
                        .font(.system(size: 35, weight: .bold, design: .rounded))
                        .foregroundStyle(.secondaryAccent)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    CustomTextField(text: self.$searchText, placeholder: "Search")
                        .overlay {
                            HStack {
                                Image(systemName: "magnifyingglass")
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                    
                    HStack {
                        ForEach(self.filterOptions, id: \.self) { filterOption in
                            HStack {
                                Text(filterOption)
                                    .fontWeight(.medium)
                                    .foregroundStyle(self.currentSelectedFilter == filterOption ? .white : .black)
                            }
                            .padding(10)
                            .background(self.currentSelectedFilter == filterOption ? .appOrange : .white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(radius: 1)
                            .onTapGesture {
                                withAnimation(.smooth(duration: 0.2)) {
                                    self.currentSelectedFilter = filterOption
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if self.currentSelectedFilter == "All" {
                        AllFilterView()
                            .padding(.top, 20)
                    } else if self.currentSelectedFilter == "Doctors" {
                        
                    } else if self.currentSelectedFilter == "Hospitls" {
                        
                    } else {
                        
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(30)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        
        
    }
}

struct AllFilterView: View {
    
    let database = Firestore.firestore()
    
    @State private var isLoading: Bool = false
    
    @State private var hospitals: Array<Hospital> = []
    
    func fetchHospitals() {
        self.isLoading = true
       let database = Firestore.firestore()
        
        database.collection("hospitals").getDocuments() { (snapshot, error) in
            if let error = error {
                
            }
            
            self.hospitals = snapshot?.documents.compactMap { doc in
                let data = doc.data()
                let id = doc.documentID
                
                let name = doc["hospitalName"] as! String
                let superadminId = doc["superadminId"] as! String
                return Hospital(hospitalId: id, hospitalName: name, superadminId: superadminId)
                
                
            } ?? []
            
        }
        
        self.isLoading = false
    }
    
    var body: some View {
        VStack {
            if self.isLoading {
                ProgressView()
                    .tint(.appOrange)
            } else {
                ForEach(self.hospitals, id: \.self) { hospital in
                    NavigationLink(destination: HospitalScreen(hospitalId: hospital.hospitalId)) {
                        HospitalCard(hospitalName: hospital.hospitalName)
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


struct HospitalCard: View {
    var hospitalName: String
    
    var body: some View {
        HStack {
            Text(self.hospitalName)
                .font(.system(size: 20, weight: .medium, design: .rounded))
                .foregroundStyle(.black.opacity(0.5))
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .background(.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 1)
    }
}


#Preview {
    SearchPage(user: .constant(.init(id: "", fullName: "", email: "", location: "", phoneNumber: "", userType: "")))
}
