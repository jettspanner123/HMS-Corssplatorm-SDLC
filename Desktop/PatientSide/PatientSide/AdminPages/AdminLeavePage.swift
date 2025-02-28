//
//  AdminLeavePage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 26/02/25.
//

import SwiftUI

struct AdminLeavePage: View {
    
    @EnvironmentObject var appStates: AppStates
    
    @State var isSelectedTab: LeaveStatus = .pending
    var filterTabOptions: Array<LeaveStatus> = [.pending, .approved, .rejected]
    
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
            SecondaryPageHeader(headingText: "Leaves")
                .offset(y: 25)
                .zIndex(12)
            
            
            ScrollView(showsIndicators: false) {
                VStack {
                    
                    SectionHeading(text: "Filter")
                   
                    
                    
                    // MARK: Filter options heading
                    HStack {
                        
                        // MARK: Filter options
                        ForEach(self.filterTabOptions, id: \.self) { filterOption in
                            
                            if self.isSelectedTab == filterOption {
                                Text(filterOption.rawValue)
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundStyle(self.isSelectedTab == filterOption ? .white : .black)
                                    .frame(maxWidth: .infinity)
                                    .padding(15)
                                    .background(.appOrange.gradient)
                                    .clipShape(Capsule())
                                    .shadow(radius: 1)
                                    .onTapGesture {
                                        withAnimation(.smooth) {
                                            self.isSelectedTab = filterOption
                                        }
                                    }
                                
                            } else {
                                Text(filterOption.rawValue)
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundStyle(self.isSelectedTab == filterOption ? .white : .black)
                                    .frame(maxWidth: .infinity)
                                    .padding(15)
                                    .background(.white)
                                    .clipShape(Capsule())
                                    .shadow(radius: 1)
                                    .onTapGesture {
                                        withAnimation(.smooth) {
                                            self.isSelectedTab = filterOption
                                        }
                                    }
                            }
                        }
                        
                    }
                    
                   
                    SectionHeading(text: "Leaves")
                        .padding(.top, 20)
                    
                    if self.appStates.leaves.filter({ $0.leaveStatus == self.isSelectedTab }).isEmpty {
                        VStack(spacing: 20) {
                            Image(systemName: "note.text")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(.gray.opacity(0.75))
                            
                            Text("No leaves found.")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                .foregroundStyle(.gray.opacity(0.75))
                        }
                        .padding(.top, 100)
                    }
                    
                    ForEach(self.$appStates.leaves, id: \.leaveId) { $leave in
                        if leave.leaveStatus == self.isSelectedTab {
                            LeaveCard(leave: $leave)
                                .transition(.offset(y: UIScreen.main.bounds.height))
                        }
                    }
                    
                    
                }
                .padding(.horizontal, 25)
                .padding(.top, 110)
            }
        }
        .background(.gray.opacity(0.2))
        .navigationBarBackButtonHidden()
    }
}

struct LeaveCard: View {
    
    @Binding var leave: Leave
    var wantButtons: Bool = true
    
    
    var body: some View {
        VStack {
            Text(self.leave.fromDoctorName)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundStyle(.appOrange.gradient)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(self.leave.leaveDescription)
                .font(.system(size: 17, weight: .regular, design: .rounded))
                .foregroundStyle(.black.opacity(0.5))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 5)
            
            HStack {
               Text("Doctor Id: ")
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundStyle(.black.opacity(0.5))
                
                Text(self.leave.fromDoctorid)
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundStyle(.black.opacity(0.25))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 10)
            
            HStack(alignment: .bottom, spacing: 30) {
                
                // MARK: From date
                VStack(alignment: .leading) {
                    
                    // MARK: From Heading
                    Text("From")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundStyle(.black.opacity(0.5))
                    
                    Text(getHumanRedableDate(from: self.leave.from))
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundStyle(.black.opacity(0.5))
                        .frame(maxWidth: .infinity)
                        .padding(5)
                        .background(.white.gradient)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .shadow(radius: 1)
                }
                
                Image(systemName: "arrow.left.arrow.right")
                    .resizable()
                    .frame(width: 13, height: 13)
                    .foregroundStyle(.black.opacity(0.5))
                    .padding(.vertical, 5)
                
                // MARK: To date
                VStack(alignment: .leading) {
                    
                     // MARK: To Heading
                    Text("To")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundStyle(.black.opacity(0.5))
                    
                    
                    Text(getHumanRedableDate(from: self.leave.to))
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundStyle(.black.opacity(0.5))
                        .frame(maxWidth: .infinity)
                        .padding(5)
                        .background(.white.gradient)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .shadow(radius: 1)
                    
                }
                
                
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 10)
            
            if !self.wantButtons {
                
                // MARK: Pending
                if self.leave.leaveStatus == .pending {
                    HStack {
                        Text(self.leave.leaveStatus.rawValue)
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 35)
                    .background(.appYellow.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    .padding(.top, 20)
                }
                
                // MARK: Completed
                if self.leave.leaveStatus == .approved {
                    HStack {
                        Text(self.leave.leaveStatus.rawValue)
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 35)
                    .background(.appGreen.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    .padding(.top, 20)
                }
                
                if self.leave.leaveStatus == .rejected {
                    HStack {
                        Text(self.leave.leaveStatus.rawValue)
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 35)
                    .background(.appRed.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                    .padding(.top, 20)
                }
               
            }
            
            
            
            if self.wantButtons {
                
                // MARK: Approve button
                HStack {
                    Text("Approve")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .background(.appGreen.gradient)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 1)
                .padding(.top, 20)
                .onTapGesture {
                    withAnimation {
                        self.leave.leaveStatus = .approved
                    }
                }
                
                // MARK: Reject button
                HStack {
                    Text("Reject")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .background(.appRed.gradient)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 1)
                .onTapGesture {
                    withAnimation {
                        self.leave.leaveStatus = .rejected
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(15)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 1)
    }
}

#Preview {
    
    var appStates = AppStates()
    AdminLeavePage()
        .environmentObject(appStates)
}
