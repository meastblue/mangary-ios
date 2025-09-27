import SwiftUI

struct Header: View {
    let onNotificationPress: () -> Void
    let hasNotifications: Bool
    @StateObject private var themeManager = ThemeManager()

    init(onNotificationPress: @escaping () -> Void, hasNotifications: Bool = false) {
        self.onNotificationPress = onNotificationPress
        self.hasNotifications = hasNotifications
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                AnimatedText(
                    "漫画",
                    fontSize: 32,
                    fontWeight: .bold,
                    usePrimaryColor: true,
                    letterSpacing: 1.5
                )

                AnimatedText(
                    "MANGARY",
                    fontSize: 14,
                    fontWeight: .light,
                    useSecondaryTextColor: true,
                    letterSpacing: 2
                )
            }

            Spacer()

            Button(action: onNotificationPress) {
                ZStack {
                    Image(systemName: "bell")
                        .font(.system(size: 24))
                        .foregroundColor(themeManager.primaryTextColor)

                    if hasNotifications {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 12, height: 12)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 1)
                            )
                            .offset(x: 6, y: -6)
                    }
                }
                .frame(width: 48, height: 48)
                .clipShape(Circle())
                .scaleEffect(1.0)
            }
            .buttonStyle(PlainButtonStyle())
            .onTapGesture {
                onNotificationPress()
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 16)
    }
}

#Preview {
    ZStack {
        Color.white
        Header(onNotificationPress: {}, hasNotifications: true)
    }
}