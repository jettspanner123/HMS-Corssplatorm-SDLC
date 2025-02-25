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
    
    @State var selectedTab: Int = 1
    @State var showProfilePage: Bool = false
    @State var showSettingPage: Bool = false
    
    @Binding var user: SendUser
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                
                ProfilePage(showProfilePage: $showProfilePage, user: self.$user)
                    .zIndex(11)
                    .offset(y: self.showProfilePage ? 0 : UIScreen.main.bounds.height)
                
                ScrollView {
                    if self.selectedTab == 0 {
                        HomePage(showProfilePage: $showProfilePage, user: self.$user)
                    } else {
//                        SearchPage(showSettingPage: $showSettingPage)
                        SearchPage(user: self.$user)
                    }
                }
                
                
                HStack {
                    TabViewBar(selectedTab: $selectedTab)
                        .zIndex(20)
                    
                    HStack {
                        Image(systemName: "xmark")
                    }
                    .frame(maxWidth: 65, maxHeight: 65)
                    .background(.white.gradient)
                    .clipShape(Circle())
                    .shadow(radius: 1)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                .offset(y: UIScreen.main.bounds.height - 180)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.gray.opacity(0.3))
        }
    }
}


#Preview {
    ContentView(user: .constant(.init(id: "123", fullName: "Uddeshya Singh", email: "uddeshya@gmail.com", location: "Patiala, Punjab", phoneNumber: "9875660105", userType: "user")))
}
