import SwiftUI

/// Logo principal de l'application avec texte personnalisable
/// Peut être utilisé dans différents contextes avec ou sans sous-titre
struct AppLogo: View {
    let subtitle: String?
    let showJapaneseText: Bool

    /// Initializer principal
    init(subtitle: String? = nil, showJapaneseText: Bool = true) {
        self.subtitle = subtitle
        self.showJapaneseText = showJapaneseText
    }

    var body: some View {
        VStack(spacing: AppConstants.Spacing.small) {
            if showJapaneseText {
                AnimatedText(
                    AppConstants.Text.appNameJapanese,
                    fontSize: 72,
                    fontWeight: .bold,
                    customColor: .white,
                    letterSpacing: 2
                )
            }

            AnimatedText(
                AppConstants.Text.appName,
                fontSize: AppConstants.FontSize.title1,
                fontWeight: .light,
                customColor: .white.opacity(0.9),
                letterSpacing: 3
            )

            if let subtitle = subtitle {
                AnimatedText(
                    subtitle,
                    fontSize: AppConstants.FontSize.subheadline,
                    fontWeight: .medium,
                    customColor: .white.opacity(0.8)
                )
                .padding(.top, AppConstants.Spacing.small)
            }
        }
        .padding(.bottom, 48)
    }
}

// MARK: - Convenience Extensions

extension AppLogo {
    /// Logo pour l'authentification avec texte japonais
    static func auth(subtitle: String? = nil) -> AppLogo {
        AppLogo(subtitle: subtitle, showJapaneseText: true)
    }

    /// Logo simplifié sans texte japonais
    static func simple(subtitle: String? = nil) -> AppLogo {
        AppLogo(subtitle: subtitle, showJapaneseText: false)
    }
}

#Preview {
    ZStack {
        DecorativeBackground.auth
        VStack(spacing: AppConstants.Spacing.xxxLarge) {
            // Logo complet avec sous-titre
            AppLogo.auth(subtitle: "Créer un compte")

            // Logo simple
            AppLogo.simple(subtitle: "Connexion")

            // Logo sans sous-titre
            AppLogo.auth()
        }
    }
}