import SwiftUI

struct AnimatedText: View {
    let text: String
    let fontSize: CGFloat
    let fontWeight: Font.Weight
    let usePrimaryColor: Bool
    let useSecondaryTextColor: Bool
    let letterSpacing: CGFloat
    let customColor: Color?

    @StateObject private var themeManager = ThemeManager()

    init(
        _ text: String,
        fontSize: CGFloat = 16,
        fontWeight: Font.Weight = .regular,
        usePrimaryColor: Bool = false,
        useSecondaryTextColor: Bool = false,
        letterSpacing: CGFloat = 0,
        customColor: Color? = nil
    ) {
        self.text = text
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.usePrimaryColor = usePrimaryColor
        self.useSecondaryTextColor = useSecondaryTextColor
        self.letterSpacing = letterSpacing
        self.customColor = customColor
    }

    var textColor: Color {
        if let customColor = customColor {
            return customColor
        } else if usePrimaryColor {
            return Color("JapanRed")
        } else if useSecondaryTextColor {
            return themeManager.secondaryTextColor
        } else {
            return themeManager.primaryTextColor
        }
    }

    var body: some View {
        Text(text)
            .font(.system(size: fontSize, weight: fontWeight))
            .foregroundColor(textColor)
            .kerning(letterSpacing)
    }
}

#Preview {
    VStack(spacing: 20) {
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

        AnimatedText(
            "Regular Text",
            fontSize: 16,
            fontWeight: .regular
        )
    }
    .padding()
}