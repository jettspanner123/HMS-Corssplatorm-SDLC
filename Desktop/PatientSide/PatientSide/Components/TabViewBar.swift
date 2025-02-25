import SwiftUI


struct TabViewBar: View {
    
    @Binding var selectedTab: Int
    
    var tabs: Array<(String, Int)> = [("Home", 0),("Find", 1), ("Appointments", 2), ("Settings", 3)]
    var body: some View {
        HStack {
            ForEach(self.tabs, id: \.self.0) { (item, index) in
                HStack {
                    Image(systemName: index == 0 ? "house.fill" : index == 1 ? "magnifyingglass" : index == 2 ? "calendar" : index == 3 ? "gear" : "")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(selectedTab != index ? .secondaryAccent : .white)
                }
                .frame(maxWidth: 65, maxHeight: 65)
                .background(selectedTab == index ? .secondaryAccent : .clear)
                .clipShape(Circle())
                .onTapGesture {
                    withAnimation(.smooth(duration: 0.2)) {
                        selectedTab = index
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
