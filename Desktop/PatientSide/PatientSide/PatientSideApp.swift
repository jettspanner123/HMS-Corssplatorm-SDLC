//
//  PatientSideApp.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 12/02/25.
//

import SwiftUI
import SwiftData
import Firebase

@main
struct PatientSideApp: App {

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            AdminDashboard()
        }
        
    }
}
