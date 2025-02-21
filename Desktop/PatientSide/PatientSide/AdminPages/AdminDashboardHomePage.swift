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
    
    // MARK: Fetching all the hospitals for the admin
    func fetchHospitals() {
        
        
        
        let database = Firestore.firestore()
        
        database.collection("hospitals").getDocuments() { (querySnapshot, error) in
            
            if let _ = error {
                
            }
            
            DispatchQueue.main.async {
                withAnimation {
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
            
            
        }
    }
    
    let numberOfColumns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        ZStack {
            VStack {
                
                // MARK: Current selected hospital headign
                SectionHeading(text: "Current Hospital")
                    .padding(.top, 10)
                    .padding(.horizontal, 25)
                
                // MARK: Current selected hospital dropdown
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(self.hospitals, id: \.hospitalId) { hospital in
                            Text(hospital.hospitalName)
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                .foregroundStyle(.black.opacity(0.5))
                                .padding(15)
                                .background(.white)
                                .clipShape(Capsule())
                                .shadow(radius: 1)
                        }
                    }
                    .padding(.horizontal, 25)
                }
                
                
                // MARK: Hospital information grid
                SectionHeading(text: "Hospital Information")
                    .padding(.top, 20)
                    .padding(.horizontal, 25)
                
                
                
                // MARK: Horizontal scrolling information cards with on click property
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        // MARK: Number of patients ( in comparison of the day before )
                        InformationCard(iconsName: "person.fill", title: "Patients", color: .appOrange, textColor: .white, infoText: 33)
                        
                        // MARK: Available Beds ( with percentage )
                        InformationCard(iconsName: "stethoscope", title: "Doctors", color: .white, textColor: .appOrange, infoText: 33)
                        
                        // MARK: Doctors Available ( with percentage )
                        NavigationLink(destination: RequestsPage()) {
                            InformationCard(iconsName: "bed.double.fill", title: "Requests", color: .white, textColor: .appOrange, infoText: 33)
                        }
                        
                        // MARK: Remarks Page
                        NavigationLink(destination: RemarksPage()) {
                            InformationCard(iconsName: "bookmark.fill", title: "Remarks", color: .white, textColor: .appOrange, infoText: 33)
                        }
                        
                    }
                    .padding(.horizontal, 25)
                }
                .scrollClipDisabled()
                
                
                
                
                SectionHeading(text: "Quick Actions")
                    .padding(.horizontal, 25)
                    .padding(.top, 20)
                
                LazyVGrid(columns: self.numberOfColumns) {
                    
                    // MARK: Add new patient
                    QuickActionCards(iconName: "plus", color: .appOrange, textColor: .white, title: "Patient")
                    
                    // MARK: Leave Requeasts
                    QuickActionCards(iconName: "text.page", color: .white, textColor: .appOrange, title: "Leaves")
                    
                    // MARK: Scheduled Appointment
                    QuickActionCards(iconName: "text.page", color: .white, textColor: .appOrange, title: "Lineup")
                    
                    
                    // TODO: Settings
                    QuickActionCards(iconName: "gear", color: .white, textColor: .appOrange, title: "Settings")
                    
                    // MARK: Records / Progress / Apple ka 14
                    QuickActionCards(iconName: "star.fill", color: .white, textColor: .appOrange, title: "Records")
                    
                    // MARK: Emergency
                    QuickActionCards(iconName: "heart.fill", color: .white, textColor: .appOrange, title: "Crisis")
                    
                    
                    
                    
                }
                .padding(.horizontal ,25)
                
                
                SectionHeading(text: "Pending Approvals")
                    .padding(.horizontal, 25)
                    .padding(.top, 20)
                
            }
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
