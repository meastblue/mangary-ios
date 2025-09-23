//
//  MainTabView.swift
//  mangary
//
//  Created by Assistant on 23/09/2025.
//

import SwiftUI

enum MainTabs {
    case dashboard, bookmark, settings, search
}

struct MainTabView: View {
    @EnvironmentObject private var authManager: AuthenticationManager
    @State private var selectedTab: MainTabs = .dashboard
    @State private var searchString = ""

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "house.fill", value: .dashboard) {
                DashboardView()
                    .environmentObject(authManager)
            }

            Tab("Bookmarks", systemImage: "bookmark.fill", value: .bookmark) {
                BookmarkView()
            }

            Tab("Settings", systemImage: "gear", value: .settings) {
                SettingsView()
                    .environmentObject(authManager)
            }

            Tab(value: .search, role: .search) {
                SearchResultsView(searchText: $searchString)
            }
        }
        .searchable(text: $searchString, placement: .automatic, prompt: "Rechercher un manga...")
        /*.preferredColorScheme(.dark)
        .background(.ultraThinMaterial)
        .tint(.white)
        .toolbarBackground(.ultraThinMaterial, for: .tabBar)
        .toolbarBackgroundVisibility(.visible, for: .tabBar)*/
    }
}

#Preview {
    MainTabView()
}
