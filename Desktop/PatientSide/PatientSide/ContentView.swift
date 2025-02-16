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
    
    @State var selectedTab: Int = 0
    @State var showProfilePage: Bool = false
    @State var showSettingPage: Bool = false
    
    @Binding var user: SendUser
    
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
                
                TabViewBar(selectedTab: $selectedTab)
                    .offset(y: UIScreen.main.bounds.height - 180)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.gray.opacity(0.2))
        }
    }
}


