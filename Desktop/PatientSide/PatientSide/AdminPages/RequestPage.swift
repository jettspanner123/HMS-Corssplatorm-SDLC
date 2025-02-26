//
//  RequestPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 21/02/25.
//

import SwiftUI

struct RequestsPage: View {
    
    
    @EnvironmentObject var appStates: AppStates
    @State var selectedRequestOngoinType: RequestOption = .accepted
    
    var requestOngoinOptions: Array<RequestOption> = [.accepted, .rejected, .pending, .hold]
    
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
                
                
                // MARK: Page heading
                SecondaryPageHeader(headingText: "Request")
                    .offset(y: 25)
                    .zIndex(12)
                
                
                // MARK: Content View
                ScrollView(showsIndicators: false) {
                    
                    
                    VStack {
                        SectionHeading(text: "Filters")
                            .padding(.horizontal, 25)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(self.requestOngoinOptions, id: \.self) { requestOngoinType in
                                    Text(requestOngoinType.rawValue.capitalized)
                                        .font(.system(size: 15, weight: .regular, design: .rounded))
                                        .foregroundStyle(self.selectedRequestOngoinType == requestOngoinType ? .white : .appOrange)
                                        .padding(15)
                                        .background(self.selectedRequestOngoinType == requestOngoinType ? .appOrange : .white)
                                        .clipShape(Capsule())
                                        .shadow(radius: 1)
                                        .onTapGesture {
                                            withAnimation(.smooth){
                                                self.selectedRequestOngoinType = requestOngoinType
                                            }
                                        }
                                }
                            }
                            .padding(.horizontal, 25)
                        }
                        .scrollClipDisabled()
                        
                        
                        SectionHeading(text: "Request")
                            .padding(.top, 20)
                            .padding(.horizontal, 25)
                        
                        if self.appStates.requests.filter({ $0.requestStatus == self.selectedRequestOngoinType }).isEmpty {
                            VStack(spacing: 20) {
                                Image(systemName: "note.text")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .foregroundStyle(.gray.opacity(0.75))
                                
                                Text("No request found.")
                                    .font(.system(size: 15, weight: .medium, design: .rounded))
                                    .foregroundStyle(.gray.opacity(0.75))
                            }
                            .padding(.top, 100)
                        }
                        

                        ForEach(self.$appStates.requests, id: \.fromUserId) { $request in
                            if self.selectedRequestOngoinType == request.requestStatus {
                                NavigationLink(destination: RequestDetailPage(request: $request)) {
                                    RequestCard(request: request)
                                        .padding(.horizontal, 25)
                                }
                                .transition(.offset(y: UIScreen.main.bounds.height))
                            }
                        }
                        
                    }
                    .padding(.top, 110)
                }
                
                
                
                
                
            }
            .background(.gray.opacity(0.3))
            .navigationBarBackButtonHidden()
        }
    }
}



#Preview {
    RequestsPage()
}
