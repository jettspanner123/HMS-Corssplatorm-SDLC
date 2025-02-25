//
//  PageHeader.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 25/02/25.
//

import SwiftUI

struct PageHeader: View {
    
    @Binding var selectedTab: Int
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appStates: AppStates
    var id: String = ""
    
    var body: some View {
        HStack {
            Text(self.selectedTab == 0 ? "Home" : self.selectedTab == 1 ? "Patients" : self.selectedTab == 2 ? "Doctors" : "Settings")
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundStyle(.secondaryAccent.gradient)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if self.id == "adminDashboard" {
                //                HStack {
                //                    HStack {
                //                        Image(systemName: "person.fill")
                //                            .resizable()
                //                            .frame(maxWidth: 20, maxHeight: 20)
                //                    }
                //                    .frame(maxWidth: 55, maxHeight: 55)
                //                    .background(.white)
                //                    .clipShape(Circle())
                //                    .shadow(radius: 1)
                ////
                //                    HStack {
                //                        Image(systemName: "bell")
                //                    }
                //                    .frame(maxWidth: 55, maxHeight: 55)
                //                    .background(.white)
                //                    .clipShape(Circle())
                //                    .shadow(radius: 1)
                //                }
                
                
                HStack {
                    Image(systemName: "door.right.hand.open")
                        .foregroundStyle(.black.opacity(0.5))
                }
                .frame(maxWidth: 50, maxHeight: 50)
                .background(.white.gradient)
                .clipShape(Circle())
                .shadow(radius: 1)
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
                
                // MARK: Add button
                HStack {
                    Image(systemName: "plus")
                        .foregroundStyle(.black.opacity(0.5))
                }
                .frame(maxWidth: 50, maxHeight: 50)
                .background(.white.gradient)
                .clipShape(Circle())
                .shadow(radius: 1)
                .onTapGesture {
                    withAnimation(.smooth(duration: 0.35)) {
                        self.appStates.showAddPage = true
                    }
                }
            }
        }
        .padding(.horizontal, 30)
        .padding(.top, 20)
    }
    
}
