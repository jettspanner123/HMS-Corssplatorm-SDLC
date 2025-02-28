//
//  PatientSearchPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 28/02/25.
//

import SwiftUI

struct PatientSearchPage: View {
    
    @Binding var user: SendUser
    
    @State var searchText: String = ""
    @State var selectedFilterOption: String = "All"
    
    @State var doctors: Array<Doctor> = [
        .init(doctorId: "doctor1", hospitalName: "Neelam Hospital", fullName: "Uddeshya Singh", username: "doc#jettspanner123", password: "Saahil123s", height: 193, weight: 93, bloodGroup: .ap, doctorName: "Dr. Uddeshya Singh", hospitalId: "hospital1", speciality: "Gayology", medicalAcomplishment: "MBBS")
    ]
    
    @State var hospitals: Array<Hospital> = [
        .init(hospitalId: "hospital1", hospitalName: "Neelam Hospital", superadminId: "healthfosys_gulam", location: "Mysurur, Karnataka", speciality: "Gayology")
    ]
    
    var filterOptions: Array<String> = ["All", "Doctors", "Hospitals"]
    
    var body: some View {
        ZStack {
            VStack {
               
                CustomTextField(text: self.$searchText, placeholder: "Search")
                    .overlay {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.black.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                    }
                    .padding(.horizontal, 25)
                
                SectionHeading(text: "Sort By")
                    .padding(.top, 20)
                    .padding(.horizontal, 25)
                
                // MARK: Horizontal filter scroll view
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(self.filterOptions, id: \.self) { option in
                            if self.selectedFilterOption == option {
                                Text(option)
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundStyle(.white)
                                    .padding(15)
                                    .background(.appOrange.gradient)
                                    .clipShape(Capsule())
                                    .shadow(radius: 1)
                                    .onTapGesture {
                                        withAnimation {
                                            self.selectedFilterOption = option
                                        }
                                    }
                                
                            } else {
                                Text(option)
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundStyle(.black.opacity(0.5))
                                    .padding(15)
                                    .background(.white.gradient)
                                    .clipShape(Capsule())
                                    .shadow(radius: 1)
                                    .onTapGesture {
                                        withAnimation {
                                            self.selectedFilterOption = option
                                        }
                                    }
                            }
                        }
                        
                        
                        
                    }
                    .padding(.horizontal, 25)
                }
                .scrollClipDisabled()
                
                if self.selectedFilterOption == "All" || self.selectedFilterOption == "Doctors" {
                    
                    // MARK: Doctor heading
                    SectionHeading(text: "Doctors")
                        .transition(.offset(y: UIScreen.main.bounds.height))
                        .padding(.top, 20)
                        .padding(.horizontal, 25)
                    
                    ForEach(self.$doctors, id: \.doctorId) { $doctor in
                        DoctorCard(doctor: doctor)
                            .transition(.offset(y: UIScreen.main.bounds.height))
                            .padding(.horizontal, 25)
                    }
                }
                
                if self.selectedFilterOption == "All" || self.selectedFilterOption == "Hospitals" {
                    SectionHeading(text: "Hospitals")
                        .transition(.offset(y: UIScreen.main.bounds.height))
                        .padding(.top, 20)
                        .padding(.horizontal, 25)
                    
                    ForEach(self.$hospitals, id: \.hospitalId) { $hospital in
                        HospitalCard(hospital: $hospital)
                            .transition(.offset(y: UIScreen.main.bounds.height))
                            .padding(.horizontal, 25)
                    }
                }
                
                
            }
            .padding(.vertical, 100)
        }
    }
}

#Preview {
    PatientSearchPage(user: .constant(.init(id: "user1", fullName: "Uddeshya Singh", email: "uddeshya@gmail.com", location: "Patiala, Punjab", phoneNumber: "9875660105", userType: "user")))
}
