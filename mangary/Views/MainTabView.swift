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
    @State private var selectedTab: MainTabs = .dashboard
    @State private var searchText = ""

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "house.fill", value: .dashboard) {
                DashboardView()
            }

            Tab("Bookmarks", systemImage: "bookmark.fill", value: .bookmark) {
                BookmarkView()
            }

            Tab("Settings", systemImage: "gear", value: .settings) {
                SettingsView()
            }

            Tab(value: .search, role: .search) {
                SearchContentView(searchText: $searchText)
            }
        }
        .searchable(text: $searchText, prompt: "Rechercher un manga...")
    }
}

#Preview {
    MainTabView()
}
