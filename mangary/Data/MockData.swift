import Foundation

struct MangaItem: Identifiable {
    let id: Int
    let title: String
    let imageUrl: String
    let progress: Int?

    init(id: Int, title: String, imageUrl: String, progress: Int? = nil) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.progress = progress
    }
}

struct MockData {
    static let categories = [
        "Action", "Adventure", "Comedy", "Drama",
        "Fantasy", "Horror", "Mystery", "Romance",
        "Sci-Fi", "Sports", "Thriller"
    ]

    static func generateManga(count: Int) -> [MangaItem] {
        let titles = [
            "One Piece", "Naruto", "Dragon Ball", "Attack on Titan",
            "Death Note", "Demon Slayer", "My Hero Academia", "Bleach",
            "Hunter x Hunter", "Fullmetal Alchemist", "Tokyo Ghoul", "Berserk"
        ]

        return (1...count).map { index in
            MangaItem(
                id: index,
                title: titles.randomElement() ?? "Manga \(index)",
                imageUrl: "https://picsum.photos/200/300?random=\(index)"
            )
        }
    }

    static func generateReadingManga(count: Int) -> [MangaItem] {
        return generateManga(count: count).map { manga in
            MangaItem(
                id: manga.id,
                title: manga.title,
                imageUrl: manga.imageUrl,
                progress: Int.random(in: 1...100)
            )
        }
    }
}