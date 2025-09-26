import SwiftUI

struct AuthBackground: View {
    var body: some View {
        ZStack {
            Color(red: 0.745, green: 0.184, blue: 0.184)

            Circle()
                .fill(Color.white.opacity(0.1))
                .frame(width: 192, height: 192)
                .offset(x: -160, y: -380)

            Circle()
                .fill(Color.white.opacity(0.05))
                .frame(width: 288, height: 288)
                .offset(x: 120, y: 0)

            Circle()
                .fill(Color.white.opacity(0.08))
                .frame(width: 224, height: 224)
                .offset(x: -80, y: 280)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    AuthBackground()
}