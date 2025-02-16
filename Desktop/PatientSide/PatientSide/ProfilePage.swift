import SwiftUI

struct ProfilePage: View {
    
    @Binding var showProfilePage: Bool
    @Binding var user: SendUser
    
    
    var body: some View {
        ZStack(alignment: .top) {
            
            HStack {
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 205)
            .background(AppBackgroundBlur(radius: 20, opaque: false))
            .ignoresSafeArea()
            .offset(y: -100)
            .zIndex(10)
            
            
            HStack {
                HStack {
                    Image(systemName: "arrow.left")
                }
                .frame(maxWidth: 60, maxHeight: 60)
                .background(.white)
                .clipShape(Circle())
                .shadow(radius: 2)
                .rotationEffect(.degrees(-90))
                .onTapGesture {
                    withAnimation {
                        self.showProfilePage = false
                    }
                }
                Spacer()
            }
            .padding(30)
            .zIndex(11)
            
            ScrollView {
                VStack() {
                    
                    
                    // MARK: Profile heading
                    Text("Profile")
                        .font(.system(size: 40, weight: .medium , design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.secondaryAccent)
                        .padding(.top, 50)
                        .padding(.bottom, 20)
                    
                    
                    // MARK: Change profile section
                    HStack(spacing: 20) {
                        
                        
                        // MARK: Image stack
                        HStack {
                            Image(systemName: "person")
                                .resizable()
                                .frame(maxWidth: 20, maxHeight: 20)
                        }
                        .frame(width: 50, height: 50)
                        .background(.white)
                        .clipShape(Circle())
                        
                        VStack(spacing: -5) {
                            Text("Uddeshya")
                                .font(.system(size: 25, weight: .regular))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("Sing")
                                .font(.system(size: 25, weight: .ultraLight))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        HStack {
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.appOrange)
                        .clipShape(Capsule())
                        
                        
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.appBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .shadow(radius: 2)
                    
                    // MARK: Document card
                    VStack {
                        
                        
                        // MARK: Document card heading
                        Text("Medical Documents")
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        
                        
                        // MARK: All documents will he shown here.
                        ZStack {
                            
                        }
                        .frame(maxWidth: .infinity, minHeight: 200)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        
                        
                        VStack(spacing: 5) {
                            
                            // MARK: Add document button
                            Text("Add Document")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                .foregroundStyle(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(.appOrange)
                                .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 20, bottomLeading: 10, bottomTrailing: 10, topTrailing: 20)))
                            
                            
                            
                            // MARK: View documents button
                            Text("View Documents")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                .foregroundStyle(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(.secondaryAccent)
                                .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 10, bottomLeading: 20, bottomTrailing: 20, topTrailing: 10)))
                            
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 10)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.appBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .shadow(radius: 2)
                }
                .padding(30)
                .padding(.top, 60)
                
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(.white)
    }
}

