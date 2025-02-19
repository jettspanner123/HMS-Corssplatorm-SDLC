//
//  AdminDashboardHomePage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 19/02/25.
//

import SwiftUI
import FirebaseFirestore

struct AdminDashboardHomePage: View {
    
    @State var currentSelectedHospital: String = "Gurunanak"
    @State var isDropDownShown: Bool = false
    
    @State var hospitals: Array<Hospital> = []
    
    func fetchHospitals() {
        let database = Firestore.firestore()
        
        database.collection("hospitals").getDocuments() { (querySnapshot, error) in
           
            if let _ = error {
                
            }
            
            self.hospitals = querySnapshot!.documents.compactMap { doc in
                let data = doc.data()
                
                let hospitalId = data["hospitalId"] as! String
                let hospitalName = data["hospitalName"] as! String
                let hospitalLocation = data["location"] as! String
                let hospitalSpeciality = data["speciality"] as! String
                
                return .init(hospitalId: hospitalId, hospitalName: hospitalName, superadminId: "", location: hospitalLocation, speciality: hospitalSpeciality)
            }
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
               
                // MARK: Current selected hospital headign
                SectionHeading(text: "Current Hospital")
                    .padding(.top, 10)
                
                // MARK: Current selected hospital dropdown
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(self.hospitals, id: \.hospitalId) { hospital in
                            Text(hospital.hospitalName)
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                .foregroundStyle(.black.opacity(0.5))
                                .padding(10)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .shadow(radius: 1)
                        }
                    }
                }
               
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 100)
        }
        .onAppear {
            self.fetchHospitals()
        }
    }
}

#Preview {
    AdminDashboard()
}
