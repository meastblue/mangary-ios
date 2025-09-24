//
//  ContentView.swift
//  mangary
//
//  Created by Massinissa Amalou on 21/09/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @StateObject private var authManager = AuthenticationManager()

    var body: some View {
            if authManager.isAuthenticated {
                MainTabView()
                    .environmentObject(authManager)
            } else {
                HomeView()
                    .environmentObject(authManager)
            }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
