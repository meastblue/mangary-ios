import SwiftUI
import Combine

/// Gestionnaire global des thèmes (clair/sombre) de l'application
/// Utilise @AppStorage pour persister le choix utilisateur
final class ThemeManager: ObservableObject {

    // MARK: - Properties

    /// État du mode sombre, persisté automatiquement
    @AppStorage("isDarkMode") var isDarkMode: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }

    // MARK: - Public Interface

    /// Bascule entre mode clair et sombre
    func toggleTheme() {
        isDarkMode.toggle()
    }

    // MARK: - Color Scheme

    /// Schéma de couleurs iOS (utilisé avec .preferredColorScheme)
    var colorScheme: ColorScheme {
        isDarkMode ? .dark : .light
    }

    // MARK: - Background Colors

    /// Couleur de fond principale de l'app
    var backgroundColor: Color {
        isDarkMode ? .black : .white
    }

    /// Couleur de surface (cartes, sections)
    var surfaceColor: Color {
        isDarkMode ? Color(.systemGray6) : .white
    }

    /// Couleur de fond des cartes avec transparence
    var cardBackgroundColor: Color {
        isDarkMode ? Color(.systemGray5).opacity(0.8) : Color.white.opacity(0.8)
    }

    // MARK: - Text Colors

    /// Couleur du texte principal
    var primaryTextColor: Color {
        isDarkMode ? .white : .black
    }

    /// Couleur du texte secondaire (sous-titres, descriptions)
    var secondaryTextColor: Color {
        Color(.systemGray)
    }

    // MARK: - Border & Accent Colors

    /// Couleur des bordures et séparateurs
    var borderColor: Color {
        isDarkMode ? Color(.systemGray4) : Color(.systemGray5)
    }

    // MARK: - Decorative Elements

    /// Couleur des éléments flottants clairs
    var floatingElementLight: Color {
        isDarkMode ? Color.white.opacity(0.02) : Color.white.opacity(0.05)
    }

    /// Couleur des éléments flottants sombres
    var floatingElementDark: Color {
        isDarkMode ? Color.gray.opacity(0.05) : Color.gray.opacity(0.1)
    }
}