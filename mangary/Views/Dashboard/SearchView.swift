import SwiftUI

struct SearchView: View {
    @State private var searchQuery = ""
    @State private var selectedCategory: String? = nil
    @StateObject private var themeManager = ThemeManager()

    var body: some View {
        NavigationStack {
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
            .searchPresentationToolbarBehavior(.avoidHidingContent)
            .onChange(of: searchQuery) {
                resetCategoryWhenSearching()
            }
            .toolbar(.hidden, for: .navigationBar)
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
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
                ForEach(MockData.categories, id: \.self) { category in
                    CategoryButton(
                        category: category,
                        onPress: { onCategorySelect(category) }
                    )
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
        }
    }
}

struct SearchResultRow: View {
    let manga: MangaItem
    let isLast: Bool
    @StateObject private var themeManager = ThemeManager()

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: manga.imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .overlay(
                            Image(systemName: "book.fill")
                                .foregroundColor(Color("JapanRed").opacity(0.3))
                        )
                }
                .frame(width: 80, height: 110)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                VStack(alignment: .leading, spacing: 6) {
                    AnimatedText(
                        manga.title,
                        fontSize: 17,
                        fontWeight: .semibold
                    )

                    AnimatedText(
                        "Auteur: Eiichiro Oda",
                        fontSize: 14,
                        useSecondaryTextColor: true
                    )

                    AnimatedText(
                        "Chapitres: 1089",
                        fontSize: 14,
                        useSecondaryTextColor: true
                    )

                    HStack(spacing: 12) {
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 12))
                                .foregroundColor(Color.yellow)
                            AnimatedText(
                                "4.8",
                                fontSize: 14
                            )
                        }

                        HStack(spacing: 4) {
                            Image(systemName: "book.circle")
                                .font(.system(size: 12))
                                .foregroundColor(themeManager.secondaryTextColor)
                            AnimatedText(
                                "Shonen",
                                fontSize: 14,
                                useSecondaryTextColor: true
                            )
                        }
                    }
                    .padding(.top, 4)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(themeManager.secondaryTextColor)
            }
            .padding(.vertical, 12)

            if !isLast {
                Rectangle()
                    .fill(themeManager.borderColor)
                    .frame(height: 0.5)
            }
        }
    }
}

struct SearchResultsView: View {
    let searchQuery: String
    @StateObject private var themeManager = ThemeManager()

    private var mockResults: [MangaItem] {
        MockData.generateManga(count: 15).filter { manga in
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
                LazyVStack(spacing: 0) {
                    ForEach(Array(mockResults.enumerated()), id: \.element.id) { index, manga in
                        SearchResultRow(
                            manga: manga,
                            isLast: index == mockResults.count - 1
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