//
//  PageHeader_t.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 25/02/25.
//

import SwiftUI


struct PageHeader_t: View {
    
    var text: String
    var body: some View {
        HStack {
            Text(self.text)
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundStyle(.secondaryAccent.gradient)
                .frame(maxWidth: .infinity, alignment: .leading)
       }
        .padding(.horizontal, 30)
        .padding(.top, 20)
    }
}
