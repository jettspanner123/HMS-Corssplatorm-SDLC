//
//  AdminPageTabView.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 19/02/25.
//

import SwiftUI
struct AdminTabViewBar: View {
    
    @Binding var selectedTab: Int
    var tabs: Array<(String, Int)> = [("Home", 0),("Find", 1), ("Appointments", 2), ("Settings", 3)]
    
    var body: some View {
        HStack {
            ForEach(self.tabs, id: \.self.0) { (item, index) in
                HStack {
                    Image(systemName: index == 0 ? "house.fill" : index == 1 ? "person.fill" : index == 2 ? "plus" : index == 3 ? "stethoscope" : "gear")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(selectedTab != index ? .secondaryAccent : .white)
                }
                .frame(maxWidth: 65, maxHeight: 65)
                .background(selectedTab == index ? .secondaryAccent : .clear)
                .clipShape(Circle())
                .onTapGesture {
                    selectedTab = index
                }
            }
        }
        .padding(8)
        .background(.white.gradient)
        .clipShape(Capsule())
        .shadow(radius: 1)
    }
}
