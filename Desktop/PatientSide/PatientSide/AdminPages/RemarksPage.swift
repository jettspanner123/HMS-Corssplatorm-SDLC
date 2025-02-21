//
//  RemarksPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 20/02/25.
//

import SwiftUI


func getInitials(name: String) -> String {
    var temp: String = ""
    
    name.split(separator: " ").forEach { item in
        temp += String(item.first!)
    }
    return temp
    
    
}

struct RemarksPage: View {
    
    
    var remarks: Array<Remarks> = [
        .init(fromUserId: "abc", fromUserName: "Uddeshya Singh", title: "Bad Food", description: "Hello is the world of hello. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening.", markAsRead: false),
        .init(fromUserId: "bca", fromUserName: "Vanshika Garg", title: "No Non Veg Food", description: "Hello is the world of hello. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening.", markAsRead: true),
        .init(fromUserId: "abc1", fromUserName: "Tanishq Biryani", title: "No Biryani Available", description: "Hello is the world of hello. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening.", markAsRead: false),
        .init(fromUserId: "abc3", fromUserName: "Harshit Bhai", title: "Nurse not good", description: "Hello is the world of hello. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening.", markAsRead: false),
        .init(fromUserId: "bca4", fromUserName: "Harnoor K", title: "Staff not up to mark", description: "Hello is the world of hello. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening. World is also the hello of the same shit that is happening.", markAsRead: true),
    ]
    
    
    @State var selectedState: Bool = true
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                
                // MARK: Top background blur for header
                HStack {
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 140)
                .background(AppBackgroundBlur(radius: 15))
                .ignoresSafeArea()
                .zIndex(11)
                
                // MARK: Page heading
                SecondaryPageHeader(headingText: "Remarks")
                    .offset(y: 25)
                    .zIndex(12)
                
                
                // MARK: Content View
                ScrollView(showsIndicators: false) {
                    
                    
                    VStack {
                        
                        SectionHeading(text: "Filters")
                        
                        HStack {
                            
                            Text("Marked")
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundStyle(self.selectedState ? .white : .black)
                                .padding(15)
                                .background(self.selectedState ? .appOrange : .white)
                                .clipShape(Capsule())
                                .shadow(radius: 1)
                                .onTapGesture {
                                    withAnimation(.smooth(duration: 0.2)) {
                                        self.selectedState = true
                                    }
                                }
                            
                            
                            Text("Un Marked")
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundStyle(!self.selectedState ? .white : .black)
                                .padding(15)
                                .background(!self.selectedState ? .appOrange : .white)
                                .clipShape(Capsule())
                                .shadow(radius: 1)
                                .onTapGesture {
                                    withAnimation(.smooth(duration: 0.2)) {
                                        self.selectedState = false
                                        
                                    }
                                }
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        SectionHeading(text: "Remarks")
                            .padding(.top, 20)
                        
                        ForEach(self.remarks, id: \.fromUserId) { remark in
                            
                            if remark.markAsRead == self.selectedState {
                                NavigationLink(destination: RemarkDetailView(remark: remark)) {
                                    RemarkCard(remark: remark)
                                }
                            }
                            
                            
                            
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.vertical, 100)
                }
            }
            .background(.gray.opacity(0.3))
            .navigationBarBackButtonHidden()
        }
        
    }
}

#Preview {
    RemarksPage()
}
