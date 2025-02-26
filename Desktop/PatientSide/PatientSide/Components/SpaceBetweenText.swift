//
//  SpaceBetweenText.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 26/02/25.
//

import SwiftUI

struct SpaceBetweenTextView: View {
    
    var firstText: String
    var secondText: String
    
    var body: some View {
        HStack {
            Text(self.firstText)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundStyle(.black.opacity(0.75))
            
            Spacer()
            
            Text(self.secondText)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundStyle(.black.opacity(0.35))
            
        }
    }
}

