import SwiftUI
struct HomePageHeading: View {
    
    @Binding var showProfilePage: Bool
    @Binding var user: SendUser
    
    var body: some View {
        HStack {
            VStack {
                Text("Hi, ")
                    .font(.system(size: 32, weight: .medium, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(self.user.fullName.split(separator: " ").first!)!")
                    .font(.system(size: 30, weight: .light, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
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
                .onTapGesture {
                    withAnimation {
                        showProfilePage = true
                    }
                }
                
                HStack {
                    Image(systemName: "bell")
                }
                .frame(maxWidth: 55, maxHeight: 55)
                .background(.white)
                .clipShape(Circle())
                .shadow(radius: 1)
            }
        }
    }
}

