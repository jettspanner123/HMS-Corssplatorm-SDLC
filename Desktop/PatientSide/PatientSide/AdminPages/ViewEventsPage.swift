//
//  AddEventPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 25/02/25.
//

import SwiftUI

struct ViewEventsPage: View {
    
    @EnvironmentObject var appStates: AppStates
    
    var filterOptions: Array<EventType> = [.bloodDonation, .charity, .checkup, .fundRaiser, .seminar, .volunteerWork]
    
    @State var selectedFilter: EventType = .bloodDonation
    @State var completedFilter: String = "Completed"
    
    
    var body: some View {
        ZStack(alignment: .top) {
            
            // MARK: Top background blur for header
            HStack {
                
            }
            .frame(maxWidth: .infinity, maxHeight: 140)
            .background(AppBackgroundBlur(radius: 15))
            .ignoresSafeArea()
            .offset(y: -15)
            .zIndex(11)
            
            // MARK: Page heading
            SecondaryPageHeader(headingText: "Events")
                .offset(y: 25)
                .zIndex(12)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    
                    SectionHeading(text: "Filter")
                        .padding(.horizontal, 25)
                    
                    HStack {
                        
                        Text("Ongoing")
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundStyle(self.completedFilter == "Completed" ? .white : .black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(self.completedFilter == "Completed" ? .appOrange : .white)
                            .clipShape(Capsule())
                            .shadow(radius: 1)
                            .onTapGesture {
                                withAnimation(.snappy) {
                                    self.completedFilter = "Completed"
                                }
                            }
                        
                        
                        Text("Completed")
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundStyle(self.completedFilter == "Incomleted" ? .white : .black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(self.completedFilter == "Incompleted" ? .appOrange : .white)
                            .clipShape(Capsule())
                            .shadow(radius: 1)
                            .onTapGesture {
                                withAnimation {
                                    self.completedFilter = "Incompleted"
                                }
                            }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 25)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(self.filterOptions, id: \.self) { filterOption in
                                Text(filterOption.rawValue)
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundStyle(self.selectedFilter == filterOption ? .white : .black)
                                    .padding(15)
                                    .background(self.selectedFilter == filterOption ? .appOrange : .white)
                                    .clipShape(Capsule())
                                    .shadow(radius: 1)
                                    .onTapGesture {
                                        withAnimation {
                                            self.selectedFilter = filterOption
                                        }
                                    }
                                
                            }
                        }
                        .padding(.horizontal, 25)
                    }
                    .scrollClipDisabled()
                    
                    SectionHeading(text: "Events")
                        .padding(.top, 20)
                        .padding(.horizontal, 25)
//                    
                    ForEach(self.$appStates.events, id: \.eventId) { event in
                        NavigationLink(destination: EventDetailsPage(event: event)) {
                            EventCard(event: event)
                                .frame(maxWidth:  .infinity, maxHeight: 300, alignment: .topLeading)
                                .padding(.horizontal, 25)
                        }
                    }
                }
                .padding(.top, 110)
                .padding(.bottom, 40)
            }
        }
        .background(.gray.opacity(0.2))
        .navigationBarBackButtonHidden()
    }
}


#Preview {
    
    var appStates = AppStates()
    ViewEventsPage()
        .environmentObject(appStates)
}
