import SwiftUI

/// Carousel horizontal pour afficher des mangas
/// Supporte l'affichage avec ou sans progression de lecture
struct MangaCarouselView: View {
    let items: [MangaItem]
    let itemsPerPage: Int
    let itemWidth: CGFloat
    let itemHeight: CGFloat
    let showProgress: Bool
    let onCardPress: (Int) -> Void

    /// Initializer pour carousel standard de mangas
    init(
        items: [MangaItem],
        itemsPerPage: Int = 3,
        itemWidth: CGFloat = 110,
        itemHeight: CGFloat = 160,
        showProgress: Bool = false,
        onCardPress: @escaping (Int) -> Void
    ) {
        self.items = items
        self.itemsPerPage = itemsPerPage
        self.itemWidth = itemWidth
        self.itemHeight = itemHeight
        self.showProgress = showProgress
        self.onCardPress = onCardPress
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AppConstants.Spacing.medium) {
                ForEach(items) { item in
                    MangaCard(
                        title: item.title,
                        imageUrl: item.imageUrl,
                        subtitle: showProgress ? "\(item.progress ?? 0)% lu" : nil,
                        width: itemWidth,
                        height: itemHeight,
                        onPress: { onCardPress(item.id) }
                    )
                }
            }
            .horizontalPadding()
        }
    }
}

// MARK: - Convenience Extensions

extension MangaCarouselView {
    /// Crée un carousel pour les mangas en cours de lecture
    static func reading(
        items: [MangaItem],
        itemsPerPage: Int = 3,
        itemWidth: CGFloat = 110,
        itemHeight: CGFloat = 160,
        onCardPress: @escaping (Int) -> Void
    ) -> MangaCarouselView {
        MangaCarouselView(
            items: items,
            itemsPerPage: itemsPerPage,
            itemWidth: itemWidth,
            itemHeight: itemHeight,
            showProgress: true,
            onCardPress: onCardPress
        )
    }

    /// Crée un carousel pour les mangas standards
    static func standard(
        items: [MangaItem],
        itemsPerPage: Int = 3,
        itemWidth: CGFloat = 110,
        itemHeight: CGFloat = 160,
        onCardPress: @escaping (Int) -> Void
    ) -> MangaCarouselView {
        MangaCarouselView(
            items: items,
            itemsPerPage: itemsPerPage,
            itemWidth: itemWidth,
            itemHeight: itemHeight,
            showProgress: false,
            onCardPress: onCardPress
        )
    }
}

#Preview {
    VStack(spacing: AppConstants.Spacing.xxxLarge) {
        // Carousel standard
        MangaCarouselView.standard(
            items: MockData.generateManga(count: 6),
            onCardPress: { _ in }
        )

        // Carousel avec progression
        MangaCarouselView.reading(
            items: MockData.generateReadingManga(count: 4),
            onCardPress: { _ in }
        )
    }
}