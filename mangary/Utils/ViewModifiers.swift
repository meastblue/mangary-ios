import SwiftUI

/// Modificateurs de vue réutilisables pour garder un style cohérent
/// Chaque modificateur a une responsabilité spécifique et claire

// MARK: - Card Styling

/// Style de carte standard avec background et bordure
struct CardStyle: ViewModifier {
    @StateObject private var themeManager = ThemeManager()

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: AppConstants.CornerRadius.medium)
                    .fill(themeManager.cardBackgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: AppConstants.CornerRadius.medium)
                            .stroke(themeManager.borderColor, lineWidth: 1)
                    )
            )
    }
}

/// Style de carte simple sans bordure
struct SimpleCardStyle: ViewModifier {
    @StateObject private var themeManager = ThemeManager()

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: AppConstants.CornerRadius.medium)
                    .fill(themeManager.cardBackgroundColor)
            )
    }
}

// MARK: - Layout Helpers

/// Padding horizontal standard
struct HorizontalPadding: ViewModifier {
    let padding: CGFloat

    init(_ padding: CGFloat = AppConstants.Spacing.xLarge) {
        self.padding = padding
    }

    func body(content: Content) -> some View {
        content.padding(.horizontal, padding)
    }
}

/// Espacement de section standard
struct SectionSpacing: ViewModifier {
    func body(content: Content) -> some View {
        content.padding(.bottom, AppConstants.Spacing.xxxLarge)
    }
}

// MARK: - Visual Effects

/// Ligne de séparation standard
struct SeparatorLine: ViewModifier {
    @StateObject private var themeManager = ThemeManager()

    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            content
            Rectangle()
                .fill(themeManager.borderColor)
                .frame(height: 0.5)
        }
    }
}

/// Ombre subtile pour les cartes
struct CardShadow: ViewModifier {
    func body(content: Content) -> some View {
        content.shadow(
            color: Color.black.opacity(0.1),
            radius: 4,
            x: 0,
            y: 2
        )
    }
}

// MARK: - Extensions pour faciliter l'usage

extension View {
    /// Applique le style de carte standard
    func cardStyle() -> some View {
        modifier(CardStyle())
    }

    /// Applique le style de carte simple
    func simpleCardStyle() -> some View {
        modifier(SimpleCardStyle())
    }

    /// Applique un padding horizontal standard
    func horizontalPadding(_ padding: CGFloat = AppConstants.Spacing.xLarge) -> some View {
        modifier(HorizontalPadding(padding))
    }

    /// Applique l'espacement de section
    func sectionSpacing() -> some View {
        modifier(SectionSpacing())
    }

    /// Ajoute une ligne de séparation en bas
    func separatorLine() -> some View {
        modifier(SeparatorLine())
    }

    /// Ajoute une ombre de carte
    func cardShadow() -> some View {
        modifier(CardShadow())
    }
}