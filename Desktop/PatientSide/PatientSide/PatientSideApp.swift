//
//  PatientSideApp.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 12/02/25.
//

import SwiftUI
import SwiftData
import Firebase

class AppStates: ObservableObject {
    @Published var showAddPage: Bool = false
}

@main
struct PatientSideApp: App {

    init() {
        FirebaseApp.configure()
    }
    
    var appStates = AppStates()
    @State var doctor: Doctor = .init(doctorId: "123", hospitalName: "Neelam", fullName: "Uddeshya SIngh", username: "jettspanner123", password: "Saahil123s", height: 183, weight: 89, bloodGroup: .abn, doctorName: "Dr. Uddeshya SIngh", hospitalId: "123", speciality: "Physiotherapist", medicalAcomplishment: "MBBS")
    @State var admin: SendAdmin = .init(adminName: "", hospitalId: "", asminUsername: "", password: "", isSuperAdmin: true, adminId: "")

    var body: some Scene {
        WindowGroup {
            AdminDashboard(admin: self.$admin)
        }
        .environmentObject(appStates)
        
    }
}
