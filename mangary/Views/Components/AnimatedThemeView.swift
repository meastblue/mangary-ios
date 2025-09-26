import SwiftUI

struct AnimatedThemeView: View {
    let useBackground: Bool
    let useSurface: Bool
    let lightColor: Color?
    let darkColor: Color?
    let width: CGFloat?
    let height: CGFloat?
    let cornerRadius: CGFloat
    let content: AnyView?

    @StateObject private var themeManager = ThemeManager()

    init(
        useBackground: Bool = false,
        useSurface: Bool = false,
        lightColor: Color? = nil,
        darkColor: Color? = nil,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        cornerRadius: CGFloat = 0,
        @ViewBuilder content: () -> some View = { EmptyView() }
    ) {
        self.useBackground = useBackground
        self.useSurface = useSurface
        self.lightColor = lightColor
        self.darkColor = darkColor
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.content = AnyView(content())
    }

    var backgroundColor: Color {
        if useBackground {
            return themeManager.backgroundColor
        } else if useSurface {
            return themeManager.surfaceColor
        } else if let lightColor = lightColor, let darkColor = darkColor {
            return themeManager.isDarkMode ? darkColor : lightColor
        } else {
            return Color.clear
        }
    }

    var body: some View {
        ZStack {
            backgroundColor
                .frame(width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))

            content
        }
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.1)

        VStack(spacing: 20) {
            AnimatedThemeView(
                lightColor: Color.white.opacity(0.05),
                darkColor: Color.gray.opacity(0.1),
                width: 192,
                height: 192,
                cornerRadius: 96
            )

            AnimatedThemeView(useBackground: true) {
                Text("Background Example")
                    .padding()
            }

            AnimatedThemeView(useSurface: true) {
                Text("Surface Example")
                    .padding()
            }
        }
    }
}