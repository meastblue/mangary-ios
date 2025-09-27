import SwiftUI

struct HomeView: View {
    @Binding var showingHome: Bool
    @Binding var isLoggedIn: Bool

    var body: some View {
        ZStack {
            ZStack {
                Color(red: 0.745, green: 0.184, blue: 0.184)

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

            VStack {
                Spacer()

                VStack(spacing: 0) {
                    VStack(spacing: 20) {
                        Text("漫画")
                            .font(.system(size: 72, weight: .bold))
                            .foregroundColor(.white)
                            .tracking(2)

                        Text("MANGARY")
                            .font(.system(size: 30, weight: .light))
                            .foregroundColor(Color.white.opacity(0.9))
                            .tracking(6)
                    }
                    .padding(.bottom, 80)

                    Button(action: {
                        showingHome = false
                    }) {
                        VStack(spacing: 4) {
                            Text("始める")
                                .font(.system(size: 30, weight: .semibold))
                                .foregroundColor(Color(red: 0.745, green: 0.184, blue: 0.184))

                            Text("Commencer")
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(Color(red: 0.745, green: 0.184, blue: 0.184).opacity(0.8))
                        }
                        .padding(.horizontal, 64)
                        .padding(.vertical, 8)
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 8)
                    .scaleEffect(1.0)
                }

                Spacer()
            }
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    HomeView(showingHome: .constant(true), isLoggedIn: .constant(false))
}
