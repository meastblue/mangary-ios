import SwiftUI

struct MangaDashboardView: View {
    @State private var selectedCategory: String? = nil
    @StateObject private var themeManager = ThemeManager()

    private let newMangaData = MockData.generateManga(count: 6)
    private let readingData = MockData.generateReadingManga(count: 4)

    var body: some View {
        NavigationStack {
            AnimatedThemeView(useBackground: true) {
                ZStack {
                    AnimatedThemeView(useSurface: true)
                        .ignoresSafeArea()

                    ScrollView {
                    if let selectedCategory = selectedCategory {
                        VStack {
                            CategoryResultsView(
                                category: selectedCategory,
                                onBackPress: handleBackToHome
                            )
                        }
                        .padding(.top, 16)
                        .padding(.bottom, 32)
                    } else {
                        VStack(spacing: 24) {
                            HeaderView(
                                onNotificationPress: handleNotificationPress,
                                hasNotifications: true
                            )

                            renderNewReleasesSection()
                            renderCategoriesSection()
                            renderReadingSection()
                        }
                        .padding(.bottom, 32)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        }
    }

    private func renderFloatingElements() -> some View {
        ZStack {
            AnimatedThemeView(
                lightColor: themeManager.floatingElementLight,
                darkColor: themeManager.floatingElementDark,
                width: 192,
                height: 192,
                cornerRadius: 96
            )
            .offset(x: -48, y: -96)

            AnimatedThemeView(
                lightColor: themeManager.floatingElementLight,
                darkColor: themeManager.floatingElementDark,
                width: 256,
                height: 256,
                cornerRadius: 128
            )
            .offset(x: 64, y: 128)

            AnimatedThemeView(
                lightColor: themeManager.floatingElementLight,
                darkColor: themeManager.floatingElementDark,
                width: 208,
                height: 208,
                cornerRadius: 104
            )
            .offset(x: 16, y: 320)
        }
    }

    private func renderNewReleasesSection() -> some View {
        SectionView(
            title: "Nouveautés",
            actionTitle: "Voir tout",
            onActionPress: handleSeeAllPress
        ) {
            HorizontalCarousel(
                itemWidth: 110,
                itemHeight: 180,
                gap: 12
            ) {
                ForEach(newMangaData, id: \.id) { item in
                    MangaCard(
                        title: item.title,
                        imageUrl: item.imageUrl,
                        width: 110,
                        height: 180,
                        onPress: { handleCardPress(item.id) }
                    )
                }
            }
        }
    }

    private func renderCategoriesSection() -> some View {
        SectionView(title: "Catégories populaires") {
            CategoryCarouselView(
                categories: MockData.categories,
                onCategoryPress: handleCategoryPress
            )
        }
    }

    private func renderReadingSection() -> some View {
        SectionView(
            title: "Lecture en cours",
            actionTitle: "Voir tout",
            onActionPress: handleSeeAllPress
        ) {
            HorizontalCarousel(
                itemWidth: 110,
                itemHeight: 180,
                gap: 12
            ) {
                ForEach(readingData, id: \.id) { item in
                    MangaCard(
                        title: item.title,
                        imageUrl: item.imageUrl,
                        subtitle: item.progress != nil ? "\(item.progress!)%" : nil,
                        width: 110,
                        height: 180,
                        onPress: { handleCardPress(item.id) }
                    )
                }
            }
        }
    }

    private func handleNotificationPress() {
        print("Notification pressed")
    }

    private func handleSeeAllPress() {
        print("See all pressed")
    }

    private func handleCategoryPress(_ category: String) {
        selectedCategory = category
    }

    private func handleBackToHome() {
        selectedCategory = nil
    }

    private func handleCardPress(_ mangaId: Int) {
        print("Card pressed: \(mangaId)")
    }
}

#Preview {
    MangaDashboardView()
}