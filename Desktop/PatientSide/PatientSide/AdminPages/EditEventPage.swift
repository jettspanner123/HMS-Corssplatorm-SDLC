//
//  EditEventPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 26/02/25.
//

import SwiftUI

struct EditEventPage: View {
    
    @Binding var event: Event
    @State var showBottomSheet: Bool = false
    
    
    @State var bottomSheetTranslation: CGSize = .zero
    
    
    let eventTypeOptions: Array<EventType> = [.bloodDonation, .charity, .checkup, .fundRaiser, .seminar]

    func setEventType(_ eventType: EventType ) {
        self.event.eventType = eventType
        withAnimation(.spring(duration: 0.35)) {
            self.showBottomSheet = false
        }
    }

    var body: some View {
        ZStack(alignment: .top) {
            
            if self.showBottomSheet {
                Color.black.opacity(0.75)
                    .ignoresSafeArea()
                    .zIndex(20)
                    .onTapGesture {
                        withAnimation(.spring(duration: 0.35)) {
                            self.showBottomSheet = false
                        }
                    }
            }
        
            
            
            if self.showBottomSheet {
                VStack {
                    VStack {
                        
                        Capsule()
                            .fill(.appOrange.opacity(0.25))
                            .stroke(.black.opacity(0.5), lineWidth: 0.5)
                            .frame(maxWidth: 50, maxHeight: 15)
                        
                        
                        // MARK: Bottom sheet headign
                        Text("Blood Group")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundStyle(.secondaryAccent)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 20)
                        
                        
                        // MARK: Event list
                        VStack(spacing: 0) {
                            
                            ForEach(self.eventTypeOptions, id: \.self) { eventType in
                                InformationListItem(key: eventType.rawValue, value: "")
                                    .onTapGesture {
                                        self.setEventType(eventType)
                                    }
                                
                                CustomDivider()
                            }
                            
                            InformationListItem(key: "O-", value: "")
                                .onTapGesture {
                                    self.setEventType(.volunteerWork)
                                }
                           
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .background(.white.gradient)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                        
                        
                        Spacer()
                            .frame(maxWidth: .infinity, maxHeight: 40)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(25)
                    .background(.appBackground)
                    .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 15, topTrailing: 15)))
                    .offset(y: self.bottomSheetTranslation.height)
                    .edgesIgnoringSafeArea(.bottom)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if value.translation.height > .zero {
                                    withAnimation(.bouncy) {
                                        self.bottomSheetTranslation = value.translation
                                    }
                                }
                            }
                            .onEnded { value in
                                if value.translation.height > 100 {
                                    withAnimation(.spring(duration: 0.35)) {
                                        self.showBottomSheet = false
                                        self.bottomSheetTranslation = .zero
                                    }
                                } else {
                                    withAnimation(.spring(duration: 0.35)) {
                                        self.bottomSheetTranslation = .zero
                                    }
                                }
                                
                            }
                    )
                                   }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .transition(.move(edge: .bottom))
                .edgesIgnoringSafeArea(.bottom)
                .zIndex(21)
            }

            
            // MARK: Adding background blur
            HStack {
                
            }
            .frame(maxWidth: .infinity, maxHeight: 140)
            .background(AppBackgroundBlur(radius: 15))
            .ignoresSafeArea()
            .offset(y: -15)
            .zIndex(11)
            
            // MARK: Page heading
            SecondaryPageHeader(headingText: "Edit")
            .offset(y: 25)
            .zIndex(12)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    
                    SectionHeading(text: "Event Name")
                    
                    // MARK: Event name field
                    CustomTextField(text: self.$event.eventName, placeholder: "Name")
                        .overlay {
                            HStack {
                               Text("AB")
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                    
                    // MARK: Event type
                    
                    
                    // MARK: Event Location
                    SectionHeading(text: "Event Location")
                        .padding(.top, 20)
                    
                    CustomTextField(text: self.$event.eventName, placeholder: "Name")
                        .overlay {
                            HStack {
                                Image(systemName: "mappin.and.ellipse")
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                    
                    
                    // MARK: Event time
                    SectionHeading(text: "Event Type")
                        .padding(.top, 20)
                    
                    HStack {
                        Text(self.event.eventType.rawValue)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 55)
                    .padding(.horizontal, 55)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    .overlay {
                        HStack {
                            Image(systemName: "drop.fill")
                                .foregroundStyle(.black.opacity(0.5))
                            Spacer()
                            
                            Image(systemName: "ellipsis")
                                .foregroundStyle(.black.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                    }
                    .onTapGesture {
                        withAnimation(.spring(duration: 0.35)) {
                            self.showBottomSheet = true
                        }
                    }
                    
                    
                    // MARK: Event time and date
                    SectionHeading(text: "Event Date & Time")
                        .padding(.top, 20)
                    
                    HStack(spacing: 0) {
                        
                        Image(systemName: "calendar")
                            .foregroundStyle(.black.opacity(0.5))
                        
                        
                        DatePicker("Date", selection: self.$event.date, displayedComponents: .date)
                            .tint(.appOrange)
                            .datePickerStyle(.compact)
                            .padding(.horizontal, 15)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .padding(.leading, 20)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    
                    
                    HStack(spacing: 0) {
                        Image(systemName: "clock.fill")
                            .foregroundStyle(.black.opacity(0.5))
                        
                        DatePicker("Time", selection: self.$event.date, displayedComponents: .hourAndMinute)
                            .tint(.appOrange)
                            .datePickerStyle(.compact)
                            .padding(.horizontal, 15)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .padding(.leading, 20)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    
                    
                    SectionHeading(text: "Event description")
                        .padding(.top, 20)
                    
                    TextEditor(text: self.$event.eventDescription)
                        .frame(maxWidth: .infinity, minHeight: 250)
                        .padding(15)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                }
                .padding(.horizontal, 25)
                .padding(.top, 110)
                .padding(.bottom, 100)
            }
        }
        .background(.gray.opacity(0.2))
        .navigationBarBackButtonHidden()
    }
}

