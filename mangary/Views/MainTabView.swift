import SwiftUI

struct MainTabView: View {
    @Binding var isLoggedIn: Bool
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            MangaDashboardView()
                .tabItem {
                    Label("Accueil", systemImage: "house.fill")
                }
                .tag(0)

            SettingsView(isLoggedIn: $isLoggedIn)
                .tabItem {
                    Label("Paramètres", systemImage: "gear")
                }
                .tag(3)
        }
        .accentColor(Color("JapanRed"))
    }
}

#Preview {
    MainTabView(isLoggedIn: .constant(true))
}
