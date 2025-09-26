import SwiftUI

struct AuthLogo: View {
    let subtitle: String?

    init(subtitle: String? = nil) {
        self.subtitle = subtitle
    }

    var body: some View {
        VStack(spacing: 8) {
            Text("漫画")
                .font(.system(size: 72, weight: .bold))
                .foregroundColor(.white)
                .tracking(2)

            Text("MANGARY")
                .font(.system(size: 32, weight: .light))
                .foregroundColor(Color.white.opacity(0.9))
                .tracking(3)

            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(Color.white.opacity(0.8))
                    .padding(.top, 8)
            }
        }
        .padding(.bottom, 48)
    }
}

#Preview {
    ZStack {
        AuthBackground()
        VStack {
            AuthLogo(subtitle: "Créer un compte")
            Spacer()
        }
    }
}