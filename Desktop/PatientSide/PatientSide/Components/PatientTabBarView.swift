//
//  PatientTabBarView.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 28/02/25.
//

import SwiftUI

struct PatientTabBarView: View {
    
    @Binding var showEmergencyPage: Bool
    @Binding var selectedTab: Int
    
    var tabs: Array<(String, Int)> = [("Home", 0), ("Search", 1)]
    
    var emergencyAction: () -> Void = {}
    var body: some View {
        HStack {
            
            
            HStack {
                ForEach(self.tabs, id: \.self.0) { (item, index) in
                    if self.selectedTab == index {
                        HStack {
                            Image(systemName: index == 0 ? "house.fill" : index == 1 ? "magnifyingglass" : "ellipsis.circle")
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
                            Image(systemName: index == 0 ? "house.fill" : index == 1 ? "magnifyingglass" : "gear")
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
            
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: 73, maxHeight: 73)
            .background(
                .emergency.gradient
            )
            .clipShape(Circle())
            .shadow(radius: 1)
            .onTapGesture {
                withAnimation {
                    self.showEmergencyPage = true
                }
            }
        }
        
    }
}
