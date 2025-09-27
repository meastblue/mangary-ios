import SwiftUI

struct ContentView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @State private var showingHome = true
    @StateObject private var themeManager = ThemeManager()

    var body: some View {
        Group {
            if showingHome {
                HomeView(showingHome: $showingHome, isLoggedIn: $isLoggedIn)
            } else if isLoggedIn {
                MainTabView(isLoggedIn: $isLoggedIn)
            } else {
                NavigationStack {
                    LoginView(isLoggedIn: $isLoggedIn)
                }
            }
        }
        .animation(.easeInOut, value: showingHome)
        .animation(.easeInOut, value: isLoggedIn)
        .environmentObject(themeManager)
        .preferredColorScheme(themeManager.colorScheme)
    }
}

#Preview {
    ContentView()
}
