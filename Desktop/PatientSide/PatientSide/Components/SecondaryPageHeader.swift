//
//  SecondaryPageHeader.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 20/02/25.
//

import SwiftUI

struct SecondaryPageHeader: View {
    
    var headingText: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack(spacing: 15) {
            
            HStack {
                Image(systemName: "arrow.left")
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
            
        }
        .padding(.horizontal, 25)
    }
}
