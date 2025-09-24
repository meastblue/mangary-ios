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


    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "house.fill", value: .dashboard) {
                NavigationStack {
                    DashboardView()
                }
            }

            Tab("Bookmarks", systemImage: "bookmark.fill", value: .bookmark) {
                NavigationStack {
                    BookmarkView()
                }
            }

            Tab("Settings", systemImage: "gear", value: .settings) {
                NavigationStack {
                    SettingsView()
                }
            }

            Tab(value: .search, role: .search) {
                NavigationStack {
                    SearchContentView()
                }
                 
            }
        }
   
    }
}

#Preview {
    MainTabView()
}
