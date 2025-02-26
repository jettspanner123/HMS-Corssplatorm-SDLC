//
//  HospitalScreen.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 17/02/25.
//

import SwiftUI
import FirebaseFirestore

struct HospitalScreen: View {
    
    @Binding var hospital: Hospital
    
    @State var doctors: Array<Doctor> = []
    
    let database = Firestore.firestore()
    
    
    var body: some View {
        VStack {
            Text(self.hospital.hospitalName)
            
            ForEach(self.doctors, id: \.doctorId) { doctor in
                if self.hospital.hospitalId == doctor.hospitalId {
                    HStack {
                        Text(doctor.fullName)
                    }
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 1)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(30)
        .background(.gray.opacity(0.2))
        .onAppear {
            
        }
    }
}

