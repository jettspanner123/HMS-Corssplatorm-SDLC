//
//  RemarkCard.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 21/02/25.
//

import SwiftUI

struct RemarkCard: View {
    
    var remark: Remarks
    var body: some View {
        VStack(spacing: 15) {
            HStack(spacing: 15) {
                
                // MARK: User avatar
                Text(getInitials(name: remark.fromUserName))
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(.appOrange.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 1)
                
                // MARK: Remark title
                Text(remark.title)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(.gray)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.appOrange.opacity(0.5))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // MARK: Remark description
            Text(remark.description)
                .foregroundStyle(.black.opacity(0.75))
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .frame(maxWidth: .infinity, maxHeight: 100, alignment: .topLeading)
        .padding(20)
        .background(.white.gradient)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 1)
        
    }
}
