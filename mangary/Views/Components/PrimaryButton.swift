import SwiftUI

/// Bouton principal de l'application avec states de loading et enabled
/// Peut être utilisé dans n'importe quel contexte nécessitant un bouton important
struct PrimaryButton: View {
    let title: String
    let isLoading: Bool
    let isEnabled: Bool
    let style: Style
    let action: () -> Void

    /// Style du bouton principal
    enum Style {
        case filled
        case outlined
        case minimal

        var backgroundColor: Color {
            switch self {
            case .filled: return .white
            case .outlined: return .clear
            case .minimal: return .clear
            }
        }

        var textColor: Color {
            switch self {
            case .filled: return AppConstants.Colors.primary
            case .outlined: return .white
            case .minimal: return AppConstants.Colors.primary
            }
        }

        var borderColor: Color? {
            switch self {
            case .filled: return nil
            case .outlined: return .white
            case .minimal: return nil
            }
        }
    }

    /// Initializer principal
    init(
        title: String,
        isLoading: Bool = false,
        isEnabled: Bool = true,
        style: Style = .filled,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isLoading = isLoading
        self.isEnabled = isEnabled
        self.style = style
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: style.textColor))
                        .scaleEffect(0.8)
                } else {
                    AnimatedText(
                        title,
                        fontSize: AppConstants.FontSize.subheadline,
                        fontWeight: .semibold,
                        customColor: style.textColor
                    )
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
        }
        .background(style.backgroundColor)
        .overlay(
            RoundedRectangle(cornerRadius: AppConstants.CornerRadius.xLarge + 8)
                .stroke(style.borderColor ?? .clear, lineWidth: 2)
        )
        .clipShape(RoundedRectangle(cornerRadius: AppConstants.CornerRadius.xLarge + 8))
        .cardShadow()
        .disabled(!isEnabled || isLoading)
        .opacity(isEnabled ? 1.0 : 0.7)
        .horizontalPadding(AppConstants.Spacing.xxxLarge)
    }
}

// MARK: - Convenience Extensions

extension PrimaryButton {
    /// Bouton principal rempli (style par défaut)
    static func filled(
        title: String,
        isLoading: Bool = false,
        isEnabled: Bool = true,
        action: @escaping () -> Void
    ) -> PrimaryButton {
        PrimaryButton(title: title, isLoading: isLoading, isEnabled: isEnabled, style: .filled, action: action)
    }

    /// Bouton principal avec contour
    static func outlined(
        title: String,
        isLoading: Bool = false,
        isEnabled: Bool = true,
        action: @escaping () -> Void
    ) -> PrimaryButton {
        PrimaryButton(title: title, isLoading: isLoading, isEnabled: isEnabled, style: .outlined, action: action)
    }

    /// Bouton principal minimal
    static func minimal(
        title: String,
        isLoading: Bool = false,
        isEnabled: Bool = true,
        action: @escaping () -> Void
    ) -> PrimaryButton {
        PrimaryButton(title: title, isLoading: isLoading, isEnabled: isEnabled, style: .minimal, action: action)
    }
}

#Preview {
    ZStack {
        DecorativeBackground.auth
        VStack(spacing: AppConstants.Spacing.large) {
            // Style rempli (par défaut)
            PrimaryButton.filled(title: "Connexion", isEnabled: true) {}

            // Style avec contour
            PrimaryButton.outlined(title: "Inscription") {}

            // Style minimal
            PrimaryButton.minimal(title: "Mot de passe oublié") {}

            // État loading
            PrimaryButton.filled(title: "Chargement...", isLoading: true) {}

            // État désactivé
            PrimaryButton.filled(title: "Désactivé", isEnabled: false) {}
        }
    }
}