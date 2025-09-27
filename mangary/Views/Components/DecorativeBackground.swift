import SwiftUI

/// Fond décoratif avec éléments géométriques
/// Peut être utilisé pour n'importe quelle vue nécessitant un arrière-plan stylisé
struct DecorativeBackground: View {
    let primaryColor: Color
    let decorativeElements: [DecorativeElement]

    /// Initializer avec couleur personnalisée et éléments décoratifs
    init(
        primaryColor: Color = AppConstants.Colors.primary,
        decorativeElements: [DecorativeElement] = DecorativeElement.defaultElements
    ) {
        self.primaryColor = primaryColor
        self.decorativeElements = decorativeElements
    }

    var body: some View {
        ZStack {
            primaryColor

            ForEach(decorativeElements.indices, id: \.self) { index in
                let element = decorativeElements[index]
                Circle()
                    .fill(Color.white.opacity(element.opacity))
                    .frame(width: element.size, height: element.size)
                    .offset(x: element.offsetX, y: element.offsetY)
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: - Supporting Types

/// Élément décoratif pour le fond
struct DecorativeElement {
    let size: CGFloat
    let opacity: Double
    let offsetX: CGFloat
    let offsetY: CGFloat

    /// Éléments décoratifs par défaut (style original auth)
    static let defaultElements: [DecorativeElement] = [
        DecorativeElement(size: 192, opacity: 0.1, offsetX: -160, offsetY: -380),
        DecorativeElement(size: 288, opacity: 0.05, offsetX: 120, offsetY: 0),
        DecorativeElement(size: 224, opacity: 0.08, offsetX: -80, offsetY: 280)
    ]
}

// MARK: - Convenience Extensions

extension DecorativeBackground {
    /// Fond décoratif avec le style d'authentification
    static var auth: DecorativeBackground {
        DecorativeBackground()
    }

    /// Fond décoratif avec couleur personnalisée
    static func custom(color: Color) -> DecorativeBackground {
        DecorativeBackground(primaryColor: color)
    }
}

#Preview {
    VStack(spacing: AppConstants.Spacing.xxxLarge) {
        // Style par défaut (auth)
        DecorativeBackground.auth
            .frame(height: 200)

        // Style personnalisé
        DecorativeBackground.custom(color: .blue)
            .frame(height: 200)
    }
}