import SwiftUI

struct BookmarkView: View {
    @State private var bookmarkedMangas = [
        "One Piece", "Attack on Titan", "My Hero Academia", "Death Note"
    ]
    @StateObject private var themeManager = ThemeManager()

    var body: some View {
        NavigationStack {
            AnimatedThemeView(useBackground: true) {
                ZStack {
                    AnimatedThemeView(useSurface: true)
                        .ignoresSafeArea()

                    if bookmarkedMangas.isEmpty {
                        emptyStateView
                    } else {
                        bookmarksList
                    }
                }
            }
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Spacer()

            Image(systemName: "bookmark.slash")
                .font(.system(size: 60))
                .foregroundColor(Color("JapanRed").opacity(0.5))

            AnimatedText(
                "Aucun favori",
                fontSize: 20,
                fontWeight: .semibold
            )

            AnimatedText(
                "Ajoutez vos mangas préférés aux favoris pour les retrouver ici",
                fontSize: 14,
                useSecondaryTextColor: true
            )
            .multilineTextAlignment(.center)
            .padding(.horizontal, 40)

            Spacer()
        }
        .navigationTitle("Favoris")
        .navigationBarTitleDisplayMode(.large)
    }

    private var bookmarksList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(bookmarkedMangas, id: \.self) { manga in
                    BookmarkedMangaRow(
                        title: manga,
                        onRemove: { removeBookmark(manga) }
                    )
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
        }
        .scrollIndicators(.hidden)
        .navigationTitle("Favoris")
        .navigationBarTitleDisplayMode(.large)
    }

    private func removeBookmark(_ manga: String) {
        bookmarkedMangas.removeAll { $0 == manga }
    }
}

struct BookmarkedMangaRow: View {
    let title: String
    let onRemove: () -> Void
    @StateObject private var themeManager = ThemeManager()

    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: "https://picsum.photos/80/100?random=\(title.hashValue)")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(themeManager.borderColor)
                    .overlay(
                        Image(systemName: "book.fill")
                            .font(.title2)
                            .foregroundColor(Color("JapanRed").opacity(0.6))
                    )
            }
            .frame(width: 80, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 8) {
                AnimatedText(
                    title,
                    fontSize: 18,
                    fontWeight: .semibold
                )

                AnimatedText(
                    "Chapitre 1045",
                    fontSize: 14,
                    useSecondaryTextColor: true
                )

                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.caption)
                        .foregroundColor(themeManager.secondaryTextColor)

                    AnimatedText(
                        "Mis à jour il y a 2 jours",
                        fontSize: 12,
                        useSecondaryTextColor: true
                    )
                }
            }

            Spacer()

            VStack(spacing: 12) {
                Button(action: onRemove) {
                    Image(systemName: "bookmark.fill")
                        .font(.title2)
                        .foregroundColor(Color("JapanRed"))
                }

                Button(action: { print("Continue reading \(title)") }) {
                    Image(systemName: "play.circle.fill")
                        .font(.title2)
                        .foregroundColor(themeManager.primaryTextColor)
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(themeManager.cardBackgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(themeManager.borderColor, lineWidth: 1)
                )
        )
    }
}

#Preview {
    BookmarkView()
}