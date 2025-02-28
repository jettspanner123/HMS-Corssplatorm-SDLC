//
//  PageHeader_t.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 25/02/25.
//

import SwiftUI


struct PageHeader_t: View {
    
    var text: String
    
    var id: String
    @Environment(\.presentationMode) var presentationMode
    
    var notificationAction: () -> Void = {}
    var profileAction: () -> Void = {}
    var body: some View {
        HStack {
            Text(self.text)
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundStyle(.secondaryAccent.gradient)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            if self.id == "DoctorHomePage" {
                
                // MARK: Notification button
//                HStack {
//                    Image(systemName: "bell.fill")
//                        .foregroundStyle(.secondaryAccent.gradient)
//                }
//                .frame(width: 50, height: 50)
//                .background(.white.gradient)
//                .clipShape(Circle())
//                .shadow(radius: 1)
//                .opacity(0.5)
//                .onTapGesture {
//                    self.notificationAction()
//                }
                
                HStack {
                    Image(systemName: "door.right.hand.open")
                        .foregroundStyle(.secondaryAccent.gradient)
                }
                .frame(width: 50, height: 50)
                .background(.white.gradient)
                .clipShape(Circle())
                .shadow(radius: 1)
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
               
                // MARK: Profile button
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundStyle(.secondaryAccent.gradient)
                }
                .frame(width: 50, height: 50)
                .background(.white.gradient)
                .clipShape(Circle())
                .shadow(radius: 1)
                .onTapGesture {
                    self.profileAction()
                }
                
            }
            
       }
        .padding(.horizontal, 30)
        .padding(.top, 20)
    }
}
