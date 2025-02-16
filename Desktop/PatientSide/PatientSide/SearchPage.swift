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
//
//struct AllFilterView: View {
//    
//    
//    func getAllHospitals() {
//        let database = Firestore.firestore()
//        
//        database.collection("hospitals").getDocuments() { (snapshot, error) in
//            if let error = error {
//                
//            } else {
//                for doc in snapshot!.documents {
//                    let data = doc.data()
//                    self.hospitalData.append(data)
//                }
//            }
//        }
//        
//        print(self.hospitalData)
//        
//        print(hospitalData)
//    }
//    
//    var body: some View {
//        VStack {
//            
//        }
//        .frame(maxWidth: .infinity)
//        .onAppear {
//            self.getAllHospitals()
//        }
//    }
//}


#Preview {
    SearchPage(user: .constant(.init(id: "", fullName: "", email: "", location: "", phoneNumber: "", userType: "")))
}
