import SwiftUI

struct SectionHeading: View {
    
    var text: String
    var body: some View {
        Text(self.text)
            .font(.system(size: 15, weight: .semibold, design: .rounded))
            .foregroundStyle(.secondaryAccent.opacity(0.5))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 10)
    }
}
