import SwiftUI

struct HomeView: View {
    @Binding var showingHome: Bool
    @Binding var isLoggedIn: Bool

    var body: some View {
        ZStack {
            // Dynamic background with depth - Couleur principale #be2f2f
            ZStack {
                Color(red: 0.745, green: 0.184, blue: 0.184) // #be2f2f

                // Floating elements for depth
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 192, height: 192)
                    .offset(x: -160, y: -380)

                Circle()
                    .fill(Color.white.opacity(0.05))
                    .frame(width: 288, height: 288)
                    .offset(x: 120, y: 0)

                Circle()
                    .fill(Color.white.opacity(0.08))
                    .frame(width: 224, height: 224)
                    .offset(x: -80, y: 280)
            }
            .ignoresSafeArea()

            // Main content - flex-1 justify-center items-center px-10
            VStack {
                Spacer()

                VStack(spacing: 0) {
                    // Logo section - items-center space-y-5 mb-20
                    VStack(spacing: 20) { // space-y-5
                        Text("漫画")
                            .font(.system(size: 72, weight: .bold)) // text-7xl font-bold
                            .foregroundColor(.white)
                            .tracking(2) // tracking-wide

                        Text("MANGARY")
                            .font(.system(size: 30, weight: .light)) // text-3xl font-light
                            .foregroundColor(Color.white.opacity(0.9))
                            .tracking(6) // letterSpacing: 6
                    }
                    .padding(.bottom, 80) // mb-20

                    // Start button - bg-white rounded-full shadow-xl px-16 py-2 active:scale-95
                    Button(action: {
                        showingHome = false
                    }) {
                        VStack(spacing: 4) { // space-y-1
                            Text("始める")
                                .font(.system(size: 30, weight: .semibold)) // text-3xl font-semibold
                                .foregroundColor(Color(red: 0.745, green: 0.184, blue: 0.184)) // usePrimaryColor (#be2f2f)

                            Text("Commencer")
                                .font(.system(size: 14, weight: .light)) // text-sm font-light
                                .foregroundColor(Color(red: 0.745, green: 0.184, blue: 0.184).opacity(0.8))
                        }
                        .padding(.horizontal, 64) // px-16
                        .padding(.vertical, 8) // py-2
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 40)) // plus ovale
                    .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 8) // shadow-xl
                    .scaleEffect(1.0) // active:scale-95 (would need gesture handling)
                }

                Spacer()
            }
            .padding(.horizontal, 40) // px-10
        }
    }
}

#Preview {
    HomeView(showingHome: .constant(true), isLoggedIn: .constant(false))
}
