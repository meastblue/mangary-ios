import SwiftUI

struct SectionView<Content: View>: View {
    let title: String
    let actionTitle: String?
    let onActionPress: (() -> Void)?
    let content: Content
    @StateObject private var themeManager = ThemeManager()

    init(
        title: String,
        actionTitle: String? = nil,
        onActionPress: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.actionTitle = actionTitle
        self.onActionPress = onActionPress
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(title)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(themeManager.primaryTextColor)

                Spacer()

                if let actionTitle = actionTitle, let onActionPress = onActionPress {
                    Button(action: onActionPress) {
                        Text(actionTitle)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color("JapanRed"))
                    }
                }
            }
            .padding(.horizontal, 20)

            content
        }
    }
}

#Preview {
    ZStack {
        Color.white
        SectionView(
            title: "Test Section",
            actionTitle: "Voir tout",
            onActionPress: {}
        ) {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 100)
        }
    }
}