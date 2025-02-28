//
//  SecondaryPageHeader.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 20/02/25.
//

import SwiftUI

enum SecondaryPageHeaderRepresentable: String {
    case doctorDetails = "Doctor Details", eventDetails = "Event Details", none = "None", doctorProfile = "Doctor Profile"
}

struct SecondaryPageHeader: View {
    
    var headingText: String
    
    var image: String = "arrow.left"
    @Environment(\.presentationMode) var presentationMode
    var id: SecondaryPageHeaderRepresentable = .none
    
    var action: () -> Void = {}
    
    var body: some View {
        HStack(spacing: 15) {
            
            HStack {
                Image(systemName: self.image)
                    .foregroundStyle(.secondaryAccent)
            }
            .frame(width: 45, height: 45)
            .background(.white)
            .clipShape(Circle())
            .shadow(radius: 1)
            .onTapGesture {
                self.presentationMode.wrappedValue.dismiss()
            }
            
            Text(self.headingText)
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundStyle(.secondaryAccent.gradient)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            if self.id == .doctorDetails {
                HStack {
                    Image(systemName: "square.and.pencil")
                        .foregroundStyle(.secondaryAccent)
                }
                .frame(width: 45, height: 45)
                .background(.white)
                .clipShape(Circle())
                .shadow(radius: 1)
                .onTapGesture {
                    self.action()
                }
            }
            
            if self.id == .doctorProfile {
                HStack {
                    Image(systemName: "square.and.pencil")
                        .foregroundStyle(.secondaryAccent)
                }
                .frame(width: 45, height: 45)
                .background(.white)
                .clipShape(Circle())
                .shadow(radius: 1)
                .onTapGesture {
                    self.action()
                }
            }
        }
        .padding(.horizontal, 25)
    }
}


struct ProfilePageHeader: View {
    
    var headingText: String
    
    var image: String = "xmark"
    var id: SecondaryPageHeaderRepresentable = .none
    var onClick: () -> Void = {}
    
    var action: () -> Void = {}
    
    var body: some View {
        HStack(spacing: 15) {
            
            HStack {
                Image(systemName: self.image)
                    .foregroundStyle(.secondaryAccent)
            }
            .frame(width: 45, height: 45)
            .background(.white)
            .clipShape(Circle())
            .shadow(radius: 1)
            .onTapGesture {
                self.onClick()
            }
            
            Text(self.headingText)
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundStyle(.secondaryAccent.gradient)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            HStack {
                Image(systemName: "square.and.pencil")
                    .foregroundStyle(.secondaryAccent)
            }
            .frame(width: 45, height: 45)
            .background(.white)
            .clipShape(Circle())
            .shadow(radius: 1)
            .onTapGesture {
                self.action()
            }
        }
        .padding(.horizontal, 25)
    }
}
