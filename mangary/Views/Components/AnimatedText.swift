import SwiftUI

/// Composant de texte avec thème automatique et styles prédéfinis
/// Simplifie l'usage des couleurs et tailles standardisées
struct AnimatedText: View {

    // MARK: - Types

    /// Styles de texte prédéfinis pour une utilisation simple
    enum Style {
        case body
        case caption
        case headline
        case title
        case largeTitle
        case primary
        case secondary

        var fontSize: CGFloat {
            switch self {
            case .caption: return AppConstants.FontSize.caption
            case .body: return AppConstants.FontSize.body
            case .headline: return AppConstants.FontSize.headline
            case .title: return AppConstants.FontSize.title2
            case .largeTitle: return AppConstants.FontSize.title1
            case .primary, .secondary: return AppConstants.FontSize.body
            }
        }

        var fontWeight: Font.Weight {
            switch self {
            case .caption, .secondary: return .regular
            case .body, .primary: return .medium
            case .headline: return .semibold
            case .title, .largeTitle: return .bold
            }
        }
    }

    // MARK: - Properties

    private let text: String
    private let fontSize: CGFloat
    private let fontWeight: Font.Weight
    private let usePrimaryColor: Bool
    private let useSecondaryTextColor: Bool
    private let letterSpacing: CGFloat
    private let customColor: Color?

    @StateObject private var themeManager = ThemeManager()

    // MARK: - Initializers

    /// Initializer principal avec tous les paramètres
    init(
        _ text: String,
        fontSize: CGFloat = AppConstants.FontSize.body,
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

    /// Initializer simplifié avec style prédéfini
    init(_ text: String, style: Style, letterSpacing: CGFloat = 0) {
        self.text = text
        self.fontSize = style.fontSize
        self.fontWeight = style.fontWeight
        self.usePrimaryColor = style == .primary
        self.useSecondaryTextColor = style == .secondary
        self.letterSpacing = letterSpacing
        self.customColor = nil
    }

    // MARK: - Computed Properties

    /// Détermine la couleur du texte selon les paramètres
    private var textColor: Color {
        if let customColor = customColor {
            return customColor
        } else if usePrimaryColor {
            return AppConstants.Colors.primary
        } else if useSecondaryTextColor {
            return themeManager.secondaryTextColor
        } else {
            return themeManager.primaryTextColor
        }
    }

    // MARK: - Body

    var body: some View {
        Text(text)
            .font(.system(size: fontSize, weight: fontWeight))
            .foregroundColor(textColor)
            .kerning(letterSpacing)
    }
}

// MARK: - Convenience Extensions

extension AnimatedText {
    /// Crée un titre principal
    static func title(_ text: String) -> AnimatedText {
        AnimatedText(text, style: .title)
    }

    /// Crée un titre large (pour les en-têtes de page)
    static func largeTitle(_ text: String) -> AnimatedText {
        AnimatedText(text, style: .largeTitle)
    }

    /// Crée un titre coloré avec la couleur principale
    static func primaryTitle(_ text: String) -> AnimatedText {
        AnimatedText(text, usePrimaryColor: true, fontWeight: .bold)
    }

    /// Crée un texte secondaire (descriptions, sous-titres)
    static func secondary(_ text: String) -> AnimatedText {
        AnimatedText(text, style: .secondary)
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