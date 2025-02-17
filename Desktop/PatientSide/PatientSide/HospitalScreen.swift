//
//  HospitalScreen.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 17/02/25.
//

import SwiftUI
import FirebaseFirestore

struct HospitalScreen: View {
    
    var hospitalId: String
    
    @State var doctors: Array<Doctor> = []
    
    func fetchDoctors() {
        let database = Firestore.firestore()
        database.collection("doctors").getDocuments() { (snapshot, error) in
            if let error = error {
                
            }
            
//            self.doctors = snapshot!.documents.compactMap { doc in
//                let doctorData = doc.data()
//                
////                let hospitalId =
//            }
        }
    }
    
    var body: some View {
        VStack {
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            self.fetchDoctors()
        }
    }
}

#Preview {
    HospitalScreen(hospitalId: "h1")
}
