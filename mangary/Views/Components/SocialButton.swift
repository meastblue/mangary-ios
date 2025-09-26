import SwiftUI

struct SocialButton: View {
    let title: String
    let iconName: String
    let backgroundColor: Color
    let textColor: Color
    let action: () -> Void

    init(title: String, iconName: String, backgroundColor: Color, textColor: Color, action: @escaping () -> Void) {
        self.title = title
        self.iconName = iconName
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(textColor)

                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(textColor)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
        }
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 8)
    }
}

#Preview {
    ZStack {
        AuthBackground()
        VStack(spacing: 20) {
            SocialButton(
                title: "Continuer avec Apple",
                iconName: "Apple",
                backgroundColor: .black,
                textColor: .white
            ) {}

            SocialButton(
                title: "Continuer avec Google",
                iconName: "Google",
                backgroundColor: .white,
                textColor: .black
            ) {}
        }
        .padding(.horizontal, 32)
    }
}