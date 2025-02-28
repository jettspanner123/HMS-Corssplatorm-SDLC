//
//  ContentView.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 12/02/25.
//

import SwiftUI
import SwiftData

func getCurrentDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEE, dd MMMM"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    let currentDate = Date()
    let formatedDate = dateFormatter.string(from: currentDate)
    return formatedDate
}


struct ContentView: View {
    
    @Binding var user: SendUser
    
    var body: some View {
        Text("Helo world")
       
    }
}


#Preview {
    ContentView(user: .constant(.init(id: "123", fullName: "Uddeshya Singh", email: "uddeshya@gmail.com", location: "Patiala, Punjab", phoneNumber: "9875660105", userType: "user")))
}
