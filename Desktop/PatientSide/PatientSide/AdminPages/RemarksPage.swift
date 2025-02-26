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
    
    @State var selectedState: Bool = true
    
    @EnvironmentObject var appStates: AppStates
    
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
                                    withAnimation(.smooth) {
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
                                    withAnimation(.smooth) {
                                        self.selectedState = false
                                        
                                    }
                                }
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        SectionHeading(text: "Remarks")
                            .padding(.top, 20)
                        
                        if self.appStates.remarks.filter({ $0.markAsRead == self.selectedState }).isEmpty {
                            VStack(spacing: 20) {
                                Image(systemName: "note.text")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .foregroundStyle(.gray.opacity(0.75))
                                
                                Text("No request found.")
                                    .font(.system(size: 15, weight: .medium, design: .rounded))
                                    .foregroundStyle(.gray.opacity(0.75))
                            }
                            .padding(.top, 100)
                        }
                        
                        ForEach(self.$appStates.remarks, id: \.fromUserId) { $remark in
                            if remark.markAsRead == self.selectedState {
                                NavigationLink(destination: RemarkDetailView(remark: $remark)) {
                                    RemarkCard(remark: remark)
                                }
                                .transition(.offset(y: UIScreen.main.bounds.height))
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
