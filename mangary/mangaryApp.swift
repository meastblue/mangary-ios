//
//  mangaryApp.swift
//  mangary
//
//  Created by Massinissa Amalou on 23/09/2025.
//

import SwiftUI
import SwiftData

@main
struct mangaryApp: App {
    @State private var authManager = AuthenticationManager()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    
    var body: some Scene {
        WindowGroup {
            Group {
                if authManager.isAuthenticated {
                    MainTabView()
                } else {
                    NavigationStack {
                        HomeView()
                    }
                }
            }
            .environment(authManager)
           
         
        }
        .modelContainer(sharedModelContainer)
    }
}
