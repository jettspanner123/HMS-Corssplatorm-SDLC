//
//  RemarkDetailView.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 21/02/25.
//

import SwiftUI
struct RemarkDetailView: View {
    
    var remark: Remarks
    var body: some View {
        ZStack(alignment: .top) {
            
            
            // MARK: Top background blur for header
            HStack {
                
            }
            .frame(maxWidth: .infinity, maxHeight: 140)
            .background(AppBackgroundBlur(radius: 15))
            .ignoresSafeArea()
            .zIndex(11)
            
            // MARK: Page heading
            
            SecondaryPageHeader(headingText: "Details")
                .offset(y: 25)
                .zIndex(12)
            
            
            // MARK: Content View
            ScrollView {
                VStack {
                    
                    
                    SectionHeading(text: "User")
                    
                    HStack(spacing: 15) {
                        
                        Text(getInitials(name: self.remark.fromUserName))
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .padding(15)
                            .background(.appOrange.gradient)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 1)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text(self.remark.fromUserName)
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                            
                            Text(self.remark.fromUserId)
                                .foregroundStyle(.black.opacity(0.5))
                            
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.appOrange)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .background(.white.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    
                    
                    
                    
                    // MARK: Remar title section heading
                    SectionHeading(text: "Remark Title")
                        .padding(.top, 20)
                    
                    // MARK: Remar title
                    Text(self.remark.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(15)
                        .background(.white.gradient)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                    
                    
                    // MARK: Remar description
                    SectionHeading(text: "Remark Description")
                        .padding(.top, 20)
                    
                    Text(self.remark.description)
                        .padding(15)
                        .background(.white.gradient)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                }
                .padding(.top, 110)
                .padding(.horizontal, 25)
                
            }
            
            
            // MARK: Mark as viewed button
            
            HStack {
                Text(self.remark.markAsRead ? "Mark Unread" : "Mark Read")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.appOrange.gradient)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(radius: 1)
            .padding(.horizontal, 25)
            .offset(y: UIScreen.main.bounds.height - 140)
            .zIndex(10)
            .onTapGesture {
            }
            
        }
        .background(.gray.opacity(0.3))
        .navigationBarBackButtonHidden()
    }
}
