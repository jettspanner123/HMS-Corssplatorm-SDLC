//
//  AdminDashboard.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 19/02/25.
//

import SwiftUI

struct AdminDashboard: View {
    
    @State var selectedTab: Int = 0
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                
                
                // MARK: Top background blur for header
                HStack {
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 140)
                .background(AppBackgroundBlur(radius: 15))
                .ignoresSafeArea()
                .offset(y: -15)
                .zIndex(11)
                
                PageHeader(selectedTab: self.$selectedTab)
                    .zIndex(12)
                
                ScrollView(showsIndicators: false) {
                    if self.selectedTab == 0 {
                        AdminDashboardHomePage()
                    } else if self.selectedTab == 1 {
                    } else if self.selectedTab == 2 {
                        
                    } else if self.selectedTab == 3 {
                        
                    }
                }
                
                
                AdminTabViewBar(selectedTab: self.$selectedTab)
                    .offset(y: UIScreen.main.bounds.height - 180)
                    .zIndex(12)
                
                // MARK: Blur at the background of tab bar
                HStack {
                    
                }
                .frame(maxWidth: .infinity, minHeight: 100)
                .background(AppBackgroundBlur(radius: 10, opaque: false))
                .offset(y: UIScreen.main.bounds.height - 140)
                
            }
            .background(.appBackground)
        }
    }
}


struct PageHeader: View {
    
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            Text("Home")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundStyle(.secondaryAccent)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                HStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(maxWidth: 20, maxHeight: 20)
                }
                .frame(maxWidth: 55, maxHeight: 55)
                .background(.white)
                .clipShape(Circle())
                .shadow(radius: 1)
                
                HStack {
                    Image(systemName: "bell")
                }
                .frame(maxWidth: 55, maxHeight: 55)
                .background(.white)
                .clipShape(Circle())
                .shadow(radius: 1)
            }
        }
        .padding(.horizontal, 30)
        .padding(.top, 20)
        
    }
    
}



#Preview {
    AdminDashboard()
}
