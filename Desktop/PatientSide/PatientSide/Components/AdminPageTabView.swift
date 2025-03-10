//
//  AdminPageTabView.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 19/02/25.
//

import SwiftUI
struct AdminTabViewBar: View {
    
    @Binding var selectedTab: Int
    var tabs: Array<(String, Int)> = [("Home", 0) ,("Hospitals", 1), ("Doctors", 2)]
    
    var body: some View {
        HStack {
            ForEach(self.tabs, id: \.self.0) { (item, index) in
                if self.selectedTab == index {
                    HStack {
                        Image(systemName: index == 0 ? "house.fill" : index == 1 ? "building.columns.fill" : index == 2 ? "stethoscope" : index == 3 ? "stethoscope" : "gear")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.white.gradient)
                    }
                    .frame(maxWidth: 65, maxHeight: 65)
                    .background(.secondaryAccent.gradient)
                    .clipShape(Circle())
                    .onTapGesture {
                        withAnimation(.smooth) {
                            selectedTab = index
                        }
                    }
                } else  {
                    HStack {
                        Image(systemName: index == 0 ? "house.fill" : index == 1 ? "building.columns.fill" : index == 2 ? "stethoscope" : index == 3 ? "stethoscope" : "gear")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.secondaryAccent.gradient)
                    }
                    .frame(maxWidth: 65, maxHeight: 65)
                    .background(.clear)
                    .clipShape(Circle())
                    .onTapGesture {
                        withAnimation(.smooth) {
                            selectedTab = index
                        }
                    }
                }
                
            }
        }
        .padding(8)
        .background(.white.gradient)
        .clipShape(Capsule())
        .shadow(radius: 1)
    }
}
