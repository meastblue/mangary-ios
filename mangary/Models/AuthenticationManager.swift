//
//  AuthenticationManager.swift
//  mangary
//
//  Created by Assistant on 23/09/2025.
//

import Foundation
import SwiftUI
import Combine

// Authentication Manager to handle auth state
final class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated = true

    func setAuthenticated(_ authenticated: Bool) {
        isAuthenticated = authenticated
    }

    func logout() {
        isAuthenticated = false
    }
}
