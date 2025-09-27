import SwiftUI

/// Constantes globales de l'application
/// Centralisées pour faciliter la maintenance et les modifications
enum AppConstants {

    // MARK: - Design System

    /// Espacements standardisés
    enum Spacing {
        static let tiny: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let xLarge: CGFloat = 20
        static let xxLarge: CGFloat = 24
        static let xxxLarge: CGFloat = 32
    }

    /// Rayons de coins standardisés
    enum CornerRadius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let xLarge: CGFloat = 20
    }

    /// Tailles de police standardisées
    enum FontSize {
        static let caption: CGFloat = 12
        static let body: CGFloat = 14
        static let subheadline: CGFloat = 16
        static let headline: CGFloat = 17
        static let title3: CGFloat = 20
        static let title2: CGFloat = 24
        static let title1: CGFloat = 32
    }

    // MARK: - Layout

    /// Dimensions des cartes manga
    enum MangaCard {
        static let width: CGFloat = 110
        static let height: CGFloat = 180
        static let searchWidth: CGFloat = 80
        static let searchHeight: CGFloat = 110
    }

    /// Dimensions des boutons de catégorie
    enum CategoryButton {
        static let width: CGFloat = 180
        static let height: CGFloat = 100
    }

    // MARK: - Animation

    /// Durées d'animation standardisées
    enum AnimationDuration {
        static let fast: TimeInterval = 0.2
        static let medium: TimeInterval = 0.3
        static let slow: TimeInterval = 0.5
    }

    // MARK: - Colors

    /// Couleurs de l'app (en plus du ThemeManager)
    enum Colors {
        static let primary = Color("JapanRed")
        static let warning = Color.yellow
        static let success = Color.green
        static let error = Color.red
    }

    // MARK: - Text

    /// Textes fréquemment utilisés
    enum Text {
        static let appName = "MANGARY"
        static let appNameJapanese = "漫画"
        static let searchPlaceholder = "Rechercher un manga..."
        static let noResults = "Aucun résultat trouvé"
        static let tryDifferentKeywords = "Essayez avec d'autres mots-clés"
    }
}