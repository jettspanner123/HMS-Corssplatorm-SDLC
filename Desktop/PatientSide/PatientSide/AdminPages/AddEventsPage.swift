//
//  AddEventsPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 26/02/25.
//

import SwiftUI

struct AddEventsPage: View {
    
    @Environment(\.presentationMode) var presentationMode
    
//    @EnvironmentObject var appStates: AppStates
    
    @State var isSubmitButtonClicked: Bool = false
    
    @State var eventName: String = ""
    @State var eventDescription: String = ""
    @State var eventType: EventType = .bloodDonation
    @State var eventDate: Date = .now
    @State var eventTime: Date = .now
    @State var eventLocation: String = ""
    
    
    @State var showBottomSheet: Bool = false
    @State var showSuccessMessage: Bool = false
    
    
    @State var bottomSheetTranslation: CGSize = .zero
    
    let eventTypeOptions: Array<EventType> = [.bloodDonation, .charity, .checkup, .fundRaiser, .seminar]

    func setEventType(_ eventType: EventType ) {
        self.eventType = eventType
        withAnimation(.spring(duration: 0.35)) {
            self.showBottomSheet = false
        }
    }
    
    @State var showErrorMessage: Bool = false
    @State var errorMessage: String = ""
    @State var errorDescription: String = ""
    
    // MARK: This fucntion is for.....bro you know what is does.
    func createEvent() -> Void {
        
        self.isSubmitButtonClicked = true
        
        if self.eventName.isEmpty || self.eventDescription.isEmpty || self.eventLocation.isEmpty {
            
            self.errorMessage = "All fields required 🥲"
            self.errorDescription = "Please make sure that all the text fields are filled properly. "
            withAnimation {
                self.showErrorMessage = true
            }
            self.isSubmitButtonClicked = false
            return
        }
        
        let event: Event = .init(eventName: self.eventName, eventDescription: self.eventDescription, eventType: self.eventType, location: self.eventLocation, date: self.eventDate)
//        self.appStates.events.append(event)
        
        self.isSubmitButtonClicked = false
        
        withAnimation {
            self.showSuccessMessage = true
        }
        self.eventName = ""
        self.eventLocation = ""
        self.eventDate = .now
        self.eventTime = .now
        self.eventLocation = ""
        self.eventDescription = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation() {
                self.showSuccessMessage = false
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            
            if self.showSuccessMessage {
                HStack {
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 80)
                .background(AppBackgroundBlur(radius: 10, opaque: false))
                .background(
                    LinearGradient(gradient: Gradient(colors: [.black.opacity(0.5), .clear]), startPoint: .top, endPoint: .bottom)
                )
                .transition(.opacity)
                .zIndex(20)
                       
            }
            
            if self.showSuccessMessage {
                Text("Event added successfully.")
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(15)
                    .background(.appGreen.gradient)
                    .clipShape(Capsule())
                    .shadow(radius: 2)
                    .offset(y: 30)
                    .transition(.offset(y: -200))
                    .zIndex(21)
                
            }
            
            if self.showErrorMessage {
                VStack {
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(25)
                .background(.black.opacity(0.5))
                .shadow(radius: 1)
                .zIndex(20)
                
            }
            
            if self.showErrorMessage {
                VStack {
                    VStack {
                        Text(self.errorMessage)
                            .font(.system(size: 25, weight: .bold, design: .rounded))
                            .foregroundStyle(.secondary)
                        
                        Text(self.errorDescription)
                            .lineLimit(2)
                            .padding(.vertical, 20)
                        
                        HStack {
                            Text("I Understand")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(.appOrange.gradient)
                        .clipShape(.rect(cornerRadius: 15))
                        .onTapGesture {
                            withAnimation(.spring(duration: 0.45)) {
                                self.showErrorMessage = false
                            }
                        }
                        
                    }
                    .padding(30)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .clipShape(.rect(cornerRadius: 14))
                    .padding(.horizontal, 25)
                    .zIndex(31)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.offset(y: 1000))
                .zIndex(31)

                
            }
            
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
            
            
            // MARK: Bottom background blur
            HStack {
            }
            .frame(maxWidth: .infinity, minHeight: 100)
            .background(AppBackgroundBlur(radius: 5, opaque: false))
            .offset(y: UIScreen.main.bounds.height - 120)
            .zIndex(9)
            
            
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
                
                Text("Add Event")
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
            .padding(.horizontal, 25)
            .offset(y: UIScreen.main.bounds.height - 145)
            .zIndex(10)
            .onTapGesture {
                self.createEvent()
            }
            
            ScrollView(showsIndicators: false) {
                VStack {
                    
                    SectionHeading(text: "Event Name")
                    
                    CustomTextField(text: self.$eventName, placeholder: "Name")
                        .overlay {
                            HStack {
                               Text("Ab")
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                    
                    SectionHeading(text: "Event Type")
                        .padding(.top, 20)
                    
                   // MARK: Event type selection
                    
                    HStack {
                        Text(self.eventType.rawValue)
                        
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
                    
                    SectionHeading(text: "Event Location")
                        .padding(.top, 20)
                    
                    CustomTextField(text: self.$eventLocation, placeholder: "Location")
                        .overlay {
                            HStack {
                                Image(systemName: "mappin.and.ellipse")
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                    
                    
                    
                    // MARK: Event time and date
                    SectionHeading(text: "Event Date & Time")
                        .padding(.top, 20)
                    
                    
                    
                    HStack(spacing: 0) {
                        
                        Image(systemName: "calendar")
                            .foregroundStyle(.black.opacity(0.5))
                        
                        
                        DatePicker("Date", selection: self.$eventDate, displayedComponents: .date)
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
                        
                        DatePicker("Time", selection: self.$eventTime, displayedComponents: .hourAndMinute)
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
                    
                    
                    // MARK: Event description
                    SectionHeading(text: "Event Description")
                        .padding(.top, 20)
                    
                    TextEditor(text: self.$eventDescription)
                        .frame(maxWidth: .infinity, minHeight: 150)
                        .padding(15)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                    
                    Spacer()
                        .frame(width: .infinity, height: 100)
                   
                }
                .padding(.top, 170)
                .padding(.horizontal, 25)
                                
            }
            
        }
        .background(.gray.opacity(0.2))
        .navigationBarBackButtonHidden()
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}


#Preview {
    AddEventsPage()
}
