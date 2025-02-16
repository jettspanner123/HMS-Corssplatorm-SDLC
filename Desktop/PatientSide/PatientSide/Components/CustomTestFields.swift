//
//  CustomTestFields.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 14/02/25.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        TextField(self.placeholder, text: self.$text, prompt: Text(self.placeholder).foregroundStyle(.black.opacity(0.5)))
            .padding(.horizontal, 50)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.white)
            .clipShape(.rect(cornerRadius: 15))
            .shadow(radius: 1)
    }
}
