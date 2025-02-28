//
//  AdminAppointmentPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 26/02/25.
//

import SwiftUI

func getTime(from date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .short
    
    return dateFormatter.string(from: date)
}

struct AdminAppointmentPage: View {
    
    @State var currentSelectedDate: Int = 0
    @State var isSubmitButtonClicked: Bool = false
    
    @EnvironmentObject var appStates: AppStates
    
    @State var selectedAppointmentFilter: AppointmentType = .upcoming
    
    
    var appointmentTypeOptions: Array<AppointmentType> = [.upcoming, .completed, .cancelled, .failed]
    
    
    var body: some View {
        
        NavigationStack {
            ZStack(alignment: .top) {
                
                // MARK: Bottom background blur
                HStack {
                }
                .frame(maxWidth: .infinity, minHeight: 100)
                .background(AppBackgroundBlur(radius: 5, opaque: false))
                .offset(y: UIScreen.main.bounds.height - 120)
                .zIndex(9)
                
                
                
                // MARK: Top background blur for header
                HStack {
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 140)
                .background(AppBackgroundBlur(radius: 15))
                .ignoresSafeArea()
                .offset(y: -15)
                .zIndex(11)
                
                // MARK: Add appointment button
                NavigationLink(destination: AddAppointmentPage()) {
                    HStack {
                        
                        HStack {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 13, height: 13)
                                .foregroundStyle(.white)
                        }
                        .padding(8)
                        .background(.white.opacity(0.25))
                        .clipShape(Circle())
                        
                        
                       Text("Add")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(.appOrange.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                }
                .padding(.horizontal, 25)
                .offset(y: UIScreen.main.bounds.height - 145)
                .zIndex(22)

                // MARK: Page heading
                SecondaryPageHeader(headingText: "Lineups")
                    .offset(y: 25)
                    .zIndex(12)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        
                        SectionHeading(text: "Date Filter")
                            .padding(.horizontal, 25)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(-3...7, id: \.self) { index in
                                    
                                    // MARK: Top pe jo date ka section hai na, ye vo hi hai.
                                    VStack {
                                        Text(String(getDayOnly(.now + TimeInterval(86400 * index)).prefix(1)))
                                            .font(.system(size: 15, weight: .bold, design: .rounded))
                                            .foregroundStyle(self.currentSelectedDate == index ? .white.opacity(0.85) : .gray.opacity(0.75))
                                            .padding(.top, 15)
                                        
                                        Text(getDateOnly(.now + TimeInterval(86400 * index)))
                                            .font(.system(size: 20, weight: .medium, design: .rounded))
                                            .foregroundStyle(self.currentSelectedDate == index ? .white.opacity(0.85) : .gray.opacity(0.75))
                                            .padding(.bottom, 15)
                                    }
                                    .frame(width: 50, height: 75, alignment: .top)
                                    .background(self.currentSelectedDate == index ? .appOrange : .white)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .shadow(radius: 1)
                                    .onTapGesture {
                                        withAnimation() {
                                            self.currentSelectedDate = index
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 25)
                        }
                        .scrollClipDisabled()
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(self.appointmentTypeOptions, id: \.self) { aT in
                                    Text(aT.rawValue)
                                        .font(.system(size: 15, weight: .regular, design: .rounded))
                                        .foregroundStyle(self.selectedAppointmentFilter == aT ? .white : .black.opacity(0.5))
                                        .padding(15)
                                        .background(self.selectedAppointmentFilter == aT ? .appOrange : .white)
                                        .clipShape(Capsule())
                                        .shadow(radius: 1)
                                        .onTapGesture {
                                            withAnimation() {
                                                self.selectedAppointmentFilter = aT
                                            }
                                        }
                                }
                            }
                            .padding(.horizontal, 25)
                        }
                        .scrollClipDisabled()
                        
                        SectionHeading(text: "Appointments")
                            .padding(.top, 20)
                            .padding(.horizontal, 25)
                        
                        
                        // MARK: If no appointments found
                        if self.appStates.appointments.filter({ $0.appointmentType == self.selectedAppointmentFilter }).isEmpty {
                            VStack(spacing: 20) {
                                Image(systemName: "note.text")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .foregroundStyle(.gray.opacity(0.75))
                                
                                Text("No appointment found.")
                                    .font(.system(size: 15, weight: .medium, design: .rounded))
                                    .foregroundStyle(.gray.opacity(0.75))
                            }
                            .padding(.top, 100)
                        }
                        
                        
                        ForEach(self.$appStates.appointments, id: \.appointmentId) { $appointment in
                            if self.selectedAppointmentFilter == appointment.appointmentType {
                                NavigationLink(destination: AppointmentDetailsPage(appointment: $appointment)) {
                                    AppointmentCard(appointment: $appointment)
                                        .padding(.horizontal, 25)
                                    
                                }
                                .transition(.offset(y: UIScreen.main.bounds.height))
                            }
                            
                        }
                    }
                    .padding(.vertical, 110)
                }
                
            }
            .background(.gray.opacity(0.2))
            .navigationBarBackButtonHidden()
        }
    }
}
