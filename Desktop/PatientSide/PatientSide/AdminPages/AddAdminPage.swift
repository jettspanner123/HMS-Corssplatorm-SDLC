//
//  AddAdminPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 24/02/25.
//

import SwiftUI

struct AddAdminPage: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var isSubmitButtonClicked: Bool = false
    
    @State var adminName: String = ""
    @State var adminEmail: String = ""
    @State var adminUsername: String = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            
            // MARK: Blur background
            HStack {
            }
            .frame(maxWidth: .infinity)
            .frame(height: 220)
            .background(
                AppBackgroundBlur(radius: 20, opaque: false)
            )
            .offset(y: -70)
            .zIndex(11)
            
            // MARK: Heading Text
            HStack(spacing: 15) {
                
                HStack {
                    Image(systemName: "arrow.left")
                }
                .frame(maxWidth: 45, maxHeight: 45)
                .background(.white)
                .clipShape(Circle())
                .shadow(radius: 1)
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
                
                Text("Add Admin")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundStyle(.secondaryAccent)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 50)
            .padding(.bottom, 20)
            .padding(30)
            .zIndex(12)
            
            
            // MARK: Submit button
            HStack {
                if self.isSubmitButtonClicked {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text("Submit")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                }
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.appOrange.gradient)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(radius: 1)
            .padding(.horizontal, 25)
            .offset(y: UIScreen.main.bounds.height - 145)
            .zIndex(10)
            .onTapGesture {
                
            }
            
            
            ScrollView {
               
                VStack {
                    
                    SectionHeading(text: "Personal Information")
                    
                    CustomTextField(text: self.$adminName, placeholder: "Name")
                        .overlay {
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                }
                .padding(.vertical, 160)
                .padding(.horizontal, 25)
            }
        }
        .background(.gray.opacity(0.2))
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    AddAdminPage()
}
