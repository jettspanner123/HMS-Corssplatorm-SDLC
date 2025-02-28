import SwiftUI

struct EventDetailsPage: View {
    
    @Binding var event: Event
    @State var showEditPage: Bool = false
    var wantEdit: Bool = true
    
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                
                
                // MARK: Adding background blur
                HStack {
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 140)
                .background(AppBackgroundBlur(radius: 15))
                .ignoresSafeArea()
                .offset(y: -15)
                .zIndex(11)
                
                // MARK: Page heading
                SecondaryPageHeader(headingText: "Details", id: self.wantEdit ? .doctorDetails : .none) {
                    self.showEditPage = true
                }
                .offset(y: 25)
                .zIndex(12)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        
                        // MARK: Event details heading
                        SectionHeading(text: "Event Details")
                        
                        VStack {
                            
                            SpaceBetweenTextView(firstText: "Name", secondText: self.event.eventName)
                            CustomDivider()
                            SpaceBetweenTextView(firstText: "Type", secondText: self.event.eventType.rawValue)
                            CustomDivider()
                            SpaceBetweenTextView(firstText: "Location", secondText: self.event.location)
                            CustomDivider()
                            SpaceBetweenTextView(firstText: "Date", secondText: getHumanRedableDate(from: self.event.date))
                            CustomDivider()
                            SpaceBetweenTextView(firstText: "Identification ", secondText: String(self.event.eventId.prefix(15)))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(15)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                        
                        
                        // MARK: Event description heading
                        SectionHeading(text: "Event Description")
                            .padding(.top, 20)
                        
                        VStack {
                            Text(self.event.eventDescription)
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundStyle(.black.opacity(0.65))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(15)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 110)
                }
            }
            .background(.gray.opacity(0.2))
            .navigationBarBackButtonHidden()
            .navigationDestination(isPresented: self.$showEditPage) {
                EditEventPage(event: self.$event)
            }
        }
        
    }
}

#Preview {
    
    @Previewable @State var event: Event = .init(eventName: "Maa Kali Blood Donation", eventDescription: "Hello world, world hello, Hello is the world but world is also hellow. Come with me in this hello world journey.", eventType: .bloodDonation, location: "Patiala, Punjab", date: .now)
    EventDetailsPage(event: $event)
}
