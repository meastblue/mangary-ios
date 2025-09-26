import SwiftUI

struct MainTabView: View {
    @Binding var isLoggedIn: Bool
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Accueil", systemImage: "house.fill", value: 0) {
                MangaDashboardView()
            }

            Tab("Recherche", systemImage: "magnifyingglass", value: 1, role: .search) {
                SearchView()
            }

            Tab("Favoris", systemImage: "bookmark.fill", value: 2) {
                BookmarkView()
            }

            Tab("Paramètres", systemImage: "gear", value: 3) {
                SettingsView(isLoggedIn: $isLoggedIn)
            }
        }
        .accentColor(Color("JapanRed"))
    }
}

#Preview {
    MainTabView(isLoggedIn: .constant(true))
}
