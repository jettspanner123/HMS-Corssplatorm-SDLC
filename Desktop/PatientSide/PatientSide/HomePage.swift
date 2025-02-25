import SwiftUI

struct HomePage: View {
    var tabs: Array<String> = ["Appointments", "Requests", "Uddeshya", "Tanishq", "Vanshika", "Namen"]
    
    @State var currentSelected: String = "Appointments"
    
    @Binding var showProfilePage: Bool
    @Binding var user: SendUser
    
    var body: some View {
        ZStack {
            VStack {
                
                
                HomePageHeading(showProfilePage: $showProfilePage, user: self.$user)
                    .zIndex(10)
                    .padding(.top, 30)
                    .padding(.horizontal, 30)
                

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(self.tabs, id: \.self) { tab in
                            Text(tab)
                                .fontWeight(.medium)
                                .foregroundStyle(currentSelected == tab ? .white : .black)
                                .padding()
                                .background(currentSelected == tab ? .appOrange : .white)
                                .clipShape(Capsule())
                                .shadow(radius: 1)
                                .onTapGesture {
                                    currentSelected = tab
                                }
                        }
                    }
                    .padding(.horizontal, 25)
                }
                .padding(.bottom, 20)
                
                if self.currentSelected == "Appointments" {
                    AppointmentTabView()
                } else if self.currentSelected == "Requests" {
                    Text("Request Tabs")
                    
                } else if self.currentSelected == "Uddeshya" {
                    Text("Ud bhai Tabs")
                }
            }
        }
        
    }
}

struct AppointmentTabView: View {
    var body: some View {
        VStack {
            ForEach(1...5, id: \.self) { _ in
                HStack {
                   Text("Hello world")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
        }
        .padding(.horizontal, 30)
    }
}

//#Preview {
//    @Previewable @State var something: Bool = false
//    @Previewable @State var user: SendUser = .init(id: "1234", fullName: "Uddeshya Singh", email: "uddeshyasingh12bsci@gmail.com", location: "Patiala, Punjab", phoneNumber: "9875660105", userType: "user")
//    HomePage(showProfilePage: $something, user: $user)
//}
