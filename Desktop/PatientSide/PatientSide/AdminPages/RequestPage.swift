//
//  RequestPage.swift
//  PatientSide
//
//  Created by Uddeshya Singh on 21/02/25.
//

import SwiftUI

struct RequestsPage: View {
    
    
    @State var requests: [Request] = [
        .init(
            fromUserId: "user123",
            fromUserName: "Alice Johnson",
            fromUserType: .patient,
            requestTitle: "Update Profile",
            requestDescription: "Change my address and phone number.",
            requestStatus: .pending,
            requestType: .update
        ),
        .init(
            fromUserId: "user456",
            fromUserName: "Dr. Smith",
            fromUserType: .doctor,
            requestTitle: "Delete Patient Record",
            requestDescription: "Remove patient John Doe's record.",
            requestStatus: .hold,
            requestType: .delete
        ),
        .init(
            fromUserId: "user789",
            fromUserName: "Admin User",
            fromUserType: .admin,
            requestTitle: "Create New User",
            requestDescription: "Create a new doctor account.",
            requestStatus: .accepted,
            requestType: .create
        ),
        .init(
            fromUserId: "user101",
            fromUserName: "Jane Doe",
            fromUserType: .patient,
            requestTitle: "Forgot Password",
            requestDescription: "I need to reset my password.",
            requestStatus: .pending,
            requestType: .forgotPassword
        )
    ]
    
    func getRequestOptionFrequency(options: Array<Request>) -> [RequestOption: Int] {
        
        var frequencyCounter: Dictionary<RequestOption, Int> = [:]
        
        for i in options {
            frequencyCounter[i.requestStatus, default: 0] += 1
        }
        
        return frequencyCounter
    }
    
    
    @State var selectedRequestOngoinType: RequestOption = .accepted
    
    var requestOngoinOptions: Array<RequestOption> = [.accepted, .rejected, .pending, .hold]
    
    var body: some View {
        
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
                                        self.selectedRequestOngoinType = requestOngoinType
                                    }
                            }
                        }
                    }
                   
                    
                    SectionHeading(text: "Request")
                        .padding(.top, 20)
                    
                    ForEach(self.requests, id: \.fromUserId) { request in
                        if self.selectedRequestOngoinType == request.requestStatus {
                            
                        }
                    }
                    
                }
                .padding(.top, 110)
                .padding(.horizontal, 25)
            }
            
            
        }
        .background(.gray.opacity(0.3))
        .navigationBarBackButtonHidden()
    }
}

struct RequestCard: View {
    
    
    var request: Request
    var body: some View {
        VStack(spacing: 15) {
            HStack(spacing: 15) {
                
                
                // MARK: User avatar
                Image(systemName: self.request.fromUserType == .doctor ? "stethoscope": "person.fill")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(.appOrange.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 1)
                
                // MARK: Remark title
                Text(self.request.requestTitle)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(.gray)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.appOrange.opacity(0.5))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // MARK: Remark description
            Text(self.request.requestDescription)
                .foregroundStyle(.black.opacity(0.75))
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .frame(maxWidth: .infinity, maxHeight: 100, alignment: .topLeading)
        .padding(20)
        .background(.white.gradient)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 1)
        
        
    }
}

#Preview {
    RequestsPage()
}
