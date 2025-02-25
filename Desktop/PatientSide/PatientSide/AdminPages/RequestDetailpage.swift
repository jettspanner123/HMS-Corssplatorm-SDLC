//
//  RequestDetailpage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 21/02/25.
//

import SwiftUI

struct RequestDetailPage: View {
    
    var request: Request
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
                        
                        Text(getInitials(name: self.request.fromUserName))
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .padding(15)
                            .background(.appOrange.gradient)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 1)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text(self.request.fromUserName)
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                            
                            Text(self.request.fromUserId)
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
                    Text(self.request.requestTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(15)
                        .background(.white.gradient)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                    
                    
                    // MARK: Remar description
                    SectionHeading(text: "Remark Description")
                        .padding(.top, 20)
                    
                    Text(self.request.requestDescription)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(15)
                        .background(.white.gradient)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 1)
                }
                .padding(.top, 110)
                .padding(.horizontal, 25)
                
            }
            
            HStack {
                
                
                // MARK: Accept Button
                HStack {
                    Image(systemName: "checkmark")
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: 65, maxHeight: 65)
                .background(.green.opacity(0.45).gradient)
                .clipShape(Circle())
                .shadow(radius: 1)
                
                
                // MARK: Reject button
                HStack {
                    Image(systemName: "xmark")
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: 65, maxHeight: 65)
                .background(.red.opacity(0.5).gradient)
                .clipShape(Circle())
                .shadow(radius: 1)
                
                // MARK: Hold button
                HStack {
                    Image(systemName: "hand.raised")
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: 65, maxHeight: 65)
                .background(.orange.opacity(0.5).gradient)
                .clipShape(Circle())
                .shadow(radius: 1)
                
                // MARK: In Progress button
                HStack {
                    Image(systemName: "progress.indicator")
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: 65, maxHeight: 65)
                .background(.gray.opacity(0.5).gradient)
                .clipShape(Circle())
                .shadow(radius: 1)
                
            }
            .padding(8)
            .background(.white.gradient)
            .clipShape(Capsule())
            .shadow(radius: 1)
            .offset(y: UIScreen.main.bounds.height - 170)
            
        }
        .background(.gray.opacity(0.3))
        .navigationBarBackButtonHidden()
    }
}
