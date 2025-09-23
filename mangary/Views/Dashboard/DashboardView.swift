//
//  DashboardView.swift
//  mangary
//
//  Created by Massinissa Amalou on 21/09/2025.
//

import SwiftUI

struct DashboardView: View {
    @State private var searchText = ""
    @EnvironmentObject private var authManager: AuthenticationManager

    var body: some View {
        ZStack {
            // Dynamic background with depth
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(.systemBackground),
                    Color(.systemGray6).opacity(0.3)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    // Header with logo and liquid glass
                    LiquidGlassCard(blur: 12, opacity: 0.1, cornerRadius: 16, shadowRadius: 8) {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("漫画")
                                    .font(.system(size: 32, weight: .bold, design: .serif))
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [Color("JapanRed"), Color("JapanRed").opacity(0.8)],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )

                                Text("MANGARY")
                                    .font(.system(size: 18, weight: .light))
                                    .foregroundColor(.primary)
                                    .tracking(2)
                            }

                            Spacer()

                            // Profile button with glass effect
                            LiquidGlassButton(action: {
                                // Profile action
                            }) {
                                Image(systemName: "person.circle.fill")
                                    .font(.system(size: 28))
                                    .foregroundColor(Color("JapanRed"))
                                    .frame(width: 40, height: 40)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                }

                // Featured section
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("Populaires")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)

                        Spacer()

                        Button("Voir tout") {
                            // See all action
                        }
                        .foregroundColor(Color("JapanRed"))
                        .font(.subheadline)
                    }
                    .padding(.horizontal, 20)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(0..<5) { index in
                                VStack(spacing: 8) {
                                    LiquidGlassCard(blur: 8, opacity: 0.06, cornerRadius: 12, shadowRadius: 4) {
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.2))
                                            .frame(width: 120, height: 160)
                                            .overlay(
                                                Text("Manga \(index + 1)")
                                                    .font(.caption)
                                                    .foregroundColor(.gray)
                                            )
                                    }

                                    Text("Titre du Manga")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 120)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }

                // Recently added section
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("Récemment ajoutés")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)

                        Spacer()

                        Button("Voir tout") {
                            // See all action
                        }
                        .foregroundColor(Color("JapanRed"))
                        .font(.subheadline)
                    }
                    .padding(.horizontal, 20)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(5..<10) { index in
                                VStack(spacing: 8) {
                                    LiquidGlassCard(blur: 8, opacity: 0.06, cornerRadius: 12, shadowRadius: 4) {
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.2))
                                            .frame(width: 120, height: 160)
                                            .overlay(
                                                Text("Manga \(index + 1)")
                                                    .font(.caption)
                                                    .foregroundColor(.gray)
                                            )
                                    }

                                    Text("Nouveau Manga")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 120)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }

                // Categories section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Catégories")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.horizontal, 20)

                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 15) {
                        ForEach(["Action", "Romance", "Aventure", "Comédie", "Drame", "Fantastique"], id: \.self) { category in
                            LiquidGlassButton(action: {
                                // Category action
                            }) {
                                HStack {
                                    Text(category)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(.primary)

                                    Spacer()

                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .padding()
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }

                    Spacer(minLength: 20)
                }
            }
        }
    }

#Preview {
    DashboardView()
}
