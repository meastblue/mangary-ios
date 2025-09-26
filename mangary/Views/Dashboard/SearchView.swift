import SwiftUI

struct SearchView: View {
    @State private var searchQuery = ""
    @State private var selectedCategory: String? = nil
    @StateObject private var themeManager = ThemeManager()

    var body: some View {
        AnimatedThemeView(useBackground: true) {
            ZStack {
                AnimatedThemeView(useSurface: true)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 0) {
                        renderContent()
                    }
                    .padding(.bottom, 32)
                }
                .scrollIndicators(.hidden)
            }
        }
        .searchable(text: $searchQuery, prompt: "Rechercher un manga...")
        .onChange(of: searchQuery) {
            resetCategoryWhenSearching()
        }
    }

    private func resetCategoryWhenSearching() {
        if !searchQuery.isEmpty {
            selectedCategory = nil
        }
    }

    @ViewBuilder
    private func renderContent() -> some View {
        if !searchQuery.isEmpty {
            SearchResultsView(searchQuery: searchQuery)
        } else if let selectedCategory = selectedCategory {
            CategoryResultsView(
                category: selectedCategory,
                onBackPress: handleBackToCategories
            )
        } else {
            CategoriesSectionView(onCategorySelect: handleCategorySelect)
        }
    }

    private func handleCategorySelect(_ category: String) {
        selectedCategory = category
    }

    private func handleBackToCategories() {
        selectedCategory = nil
    }
}

struct CategoriesSectionView: View {
    let onCategorySelect: (String) -> Void

    var body: some View {
        VStack(spacing: 24) {
            SectionView(title: "Catégories populaires") {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
                    ForEach(MockData.categories, id: \.self) { category in
                        CategoryButton(
                            category: category,
                            onPress: { onCategorySelect(category) }
                        )
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct SearchResultsView: View {
    let searchQuery: String
    @StateObject private var themeManager = ThemeManager()

    private var mockResults: [MangaItem] {
        MockData.generateManga(count: 8).filter { manga in
            manga.title.localizedCaseInsensitiveContains(searchQuery)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                AnimatedText(
                    "Résultats pour \"\(searchQuery)\"",
                    fontSize: 20,
                    fontWeight: .semibold
                )
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)

            if mockResults.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 48))
                        .foregroundColor(themeManager.secondaryTextColor)

                    AnimatedText(
                        "Aucun résultat trouvé",
                        fontSize: 18,
                        fontWeight: .semibold
                    )

                    AnimatedText(
                        "Essayez avec d'autres mots-clés",
                        fontSize: 14,
                        useSecondaryTextColor: true
                    )
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 60)
            } else {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 16) {
                    ForEach(mockResults) { manga in
                        MangaCard(
                            title: manga.title,
                            imageUrl: manga.imageUrl,
                            width: 160,
                            height: 200,
                            onPress: { print("Selected: \(manga.title)") }
                        )
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    SearchView()
}