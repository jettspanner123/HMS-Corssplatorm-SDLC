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
    @EnvironmentObject var appStates: AppStates
    
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
                    .padding(.horizontal, 20)
                
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
                    .padding(.horizontal, 20)
                }
                .scrollClipDisabled()
                
                
                // MARK: Hospital information grid
                SectionHeading(text: "Hospital Information")
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                
                
                
                // MARK: Horizontal scrolling information cards with on click property
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    let patients = self.appStates.users.count
                    let doctors = self.appStates.doctors.count
                    let request = self.appStates.requests.count
                    let remarks = self.appStates.remarks.count
                    HStack {
                        // MARK: Number of patients ( in comparison of the day before )
                        NavigationLink(destination: AdminPagePatientsPage()) {
                            InformationCard(iconsName: "person.fill", title: "Patients", color: .appOrange, textColor: .white, infoText: patients)
                        }
                        
                        // MARK: Available Beds ( with percentage )
                        NavigationLink(destination: AvailableDoctorsPage()) {
                            InformationCard(iconsName: "stethoscope", title: "Doctors", color: .white, textColor: .appOrange, infoText: doctors)
                        }
                        
                        // MARK: Doctors Available ( with percentage )
                        NavigationLink(destination: RequestsPage()) {
                            InformationCard(iconsName: "bed.double.fill", title: "Requests", color: .white, textColor: .appOrange, infoText: request)
                        }
                        
                        // MARK: Remarks Page
                        NavigationLink(destination: RemarksPage()) {
                            InformationCard(iconsName: "bookmark.fill", title: "Remarks", color: .white, textColor: .appOrange, infoText: remarks)
                        }
                        
                    }
                    .padding(.horizontal, 20)
                }
                .scrollClipDisabled()
                
                
                
                
                SectionHeading(text: "Quick Actions")
                    .padding(.horizontal, 25)
                    .padding(.top, 20)
                
                LazyVGrid(columns: self.numberOfColumns) {
                    
                    // MARK: Add new patient
                    NavigationLink(destination: AddPatientPage()) {
                        QuickActionCards(iconName: "plus", color: .appOrange, textColor: .white, title: "Patient")
                    }
                    
                    // MARK: Leave Requeasts
                    NavigationLink(destination: AdminLeavePage()) {
                        QuickActionCards(iconName: "text.page", color: .white, textColor: .appOrange, title: "Leaves")
                    }
                    
                    // MARK: Scheduled Appointment
                    NavigationLink(destination: AdminAppointmentPage()) {
                        QuickActionCards(iconName: "text.page", color: .white, textColor: .appOrange, title: "Lineups")
                    }
                    
                    
                    QuickActionCards(iconName: "heart.fill", color: .white, textColor: .appOrange, title: "Crisis")

                    // TODO: Settings
                    
                    // MARK: Records / Progress / Apple ka 14
                    
                    // MARK: Emergency
                    
                    
                    
                    
                }
                .padding(.horizontal ,20)
                
                
                SectionHeading(text: "Events & Campaigns")
                    .padding(.horizontal, 25)
                    .padding(.top, 20)
                
                HStack {
                    VStack(spacing: 0) {
                        Text(String(self.appStates.events.count))
                            .font(.system(size: 105, weight: .black, design: .monospaced))
                            .foregroundStyle(.appOrange.gradient)
                        
                        Text("Ongoing Events")
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .foregroundStyle(.black.opacity(0.5))
                            .offset(y: -15)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.white.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    
                    
                    VStack {
                        NavigationLink(destination: AddEventsPage()) {
                            QuickActionCards(iconName: "plus", color: .appOrange, textColor: .white, title: "Event")
                        }
                        NavigationLink(destination: ViewEventsPage()) {
                            QuickActionCards(iconName: "eye.fill", color: .white, textColor: .black.opacity(0.5), title: "See All")
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 25)
                
                
                SectionHeading(text: "Current Ongoing Events")
                    .padding(.top, 20)
                    .padding(.horizontal, 25)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(self.$appStates.events, id: \.eventId) { event in
                            NavigationLink(destination: EventDetailsPage(event: event)) {
                                EventCard(event: event)
                                .frame(width: 275, height: 175, alignment: .topLeading)
                            }
                            
                        }
                    }
                    .padding(.horizontal, 25)
                    
                }
                .scrollClipDisabled()
                
                Text("- That's All -")
                    .font(.system(size: 16, weight: .light, design: .rounded))
                    .foregroundStyle(.black.opacity(0.5))
                    .padding(.vertical, 20)
                
                Spacer()
                    .frame(maxWidth: .infinity, maxHeight: 30)
                
            }
            .padding(.vertical, 100)
        }
        .onAppear {
            self.fetchHospitals()
        }
    }
}



struct EventCard: View {
    
    @Binding var event: Event
    var imageName: String = ""
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                
                
                // MARK: Image box
                HStack  {
                    switch(self.event.eventType) {
                    case .bloodDonation:
                        Image(systemName: "drop.fill")
                            .foregroundStyle(.white)
                    case .charity:
                        Image(systemName: "gift.fill")
                            .foregroundStyle(.white)
                    case .checkup:
                        Image(systemName: "stethoscope")
                            .foregroundStyle(.white)
                    case .fundRaiser:
                        Image(systemName: "indianrupeesign")
                            .foregroundStyle(.white)
                    case .seminar:
                        Image(systemName: "bubble.left.fill")
                            .foregroundStyle(.white)
                    case .volunteerWork:
                        Image(systemName: "person.fill")
                            .foregroundStyle(.white)
                    }
                }
                .padding(10)
                .background(.appOrange.gradient)
                .clipShape(Circle())
                
                // MARK: Event name and date
                VStack(alignment: .leading) {
                    Text(self.event.eventName)
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .lineLimit(1)
                        .foregroundStyle(.black.opacity(0.5))
                    
                    Text(getHumanRedableDate(from: self.event.date))
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.black.opacity(0.35))
                }
                
                Spacer()
                
                // MARK: Navigation arrow button
                Image(systemName: "chevron.right")
                    .foregroundStyle(.black.opacity(0.5))
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            // MARK: Event description
            Text(self.event.eventDescription)
                .font(.system(size: 14, weight: .regular, design: .rounded))
                .foregroundStyle(.black.opacity(0.5))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(3)
                .padding(5)
            
            Spacer()
            
            // MARK: Event locaiton
            Text(self.event.location)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundStyle(.appOrange)
                .padding(.horizontal, 7)
        }
        .padding(20)
        .background(.white.gradient)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 1)
    }
}

#Preview {
    @Previewable @EnvironmentObject var appStates: AppStates
    AdminDashboardHomePage()
        .environmentObject(appStates)
}
