import Foundation

// MARK: - Data Models

/// Modèle représentant un manga dans l'application
/// Utilisé à travers toute l'app pour afficher les informations des mangas
struct MangaItem: Identifiable, Hashable {
    let id: Int
    let title: String
    let imageUrl: String
    let progress: Int?

    /// Crée un nouveau manga
    /// - Parameters:
    ///   - id: Identifiant unique du manga
    ///   - title: Titre du manga
    ///   - imageUrl: URL de l'image de couverture
    ///   - progress: Pourcentage de progression de lecture (optionnel)
    init(id: Int, title: String, imageUrl: String, progress: Int? = nil) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.progress = progress
    }

    /// URL formatée pour l'image de couverture
    var formattedImageUrl: URL? {
        URL(string: imageUrl)
    }

    /// Texte de progression formaté pour l'affichage
    var progressText: String? {
        guard let progress = progress else { return nil }
        return "\(progress)%"
    }
}

// MARK: - Mock Data Generator

/// Générateur de données de test pour le développement
/// Permet de tester l'interface sans backend réel
enum MockData {

    // MARK: - Categories

    /// Liste des catégories de manga disponibles
    static let categories = [
        "Action", "Adventure", "Comedy", "Drama",
        "Fantasy", "Horror", "Mystery", "Romance",
        "Sci-Fi", "Sports", "Thriller"
    ]

    // MARK: - Sample Titles

    /// Titres de manga populaires pour les tests
    private static let sampleTitles = [
        "One Piece", "Naruto", "Dragon Ball", "Attack on Titan",
        "Death Note", "Demon Slayer", "My Hero Academia", "Bleach",
        "Hunter x Hunter", "Fullmetal Alchemist", "Tokyo Ghoul", "Berserk",
        "Jujutsu Kaisen", "Chainsaw Man", "Spy x Family", "Mob Psycho 100"
    ]

    // MARK: - Generation Methods

    /// Génère une liste de mangas pour les tests
    /// - Parameter count: Nombre de mangas à générer
    /// - Returns: Liste de MangaItem
    static func generateManga(count: Int) -> [MangaItem] {
        return (1...count).map { index in
            MangaItem(
                id: index,
                title: sampleTitles.randomElement() ?? "Manga \(index)",
                imageUrl: generateImageUrl(for: index)
            )
        }
    }

    /// Génère une liste de mangas en cours de lecture
    /// - Parameter count: Nombre de mangas à générer
    /// - Returns: Liste de MangaItem avec progression
    static func generateReadingManga(count: Int) -> [MangaItem] {
        return generateManga(count: count).map { manga in
            MangaItem(
                id: manga.id,
                title: manga.title,
                imageUrl: manga.imageUrl,
                progress: generateRandomProgress()
            )
        }
    }

    // MARK: - Helper Methods

    /// Génère une URL d'image aléatoire
    private static func generateImageUrl(for index: Int) -> String {
        "https://picsum.photos/200/300?random=\(index)"
    }

    /// Génère un pourcentage de progression aléatoire
    private static func generateRandomProgress() -> Int {
        Int.random(in: 5...95)
    }
}