import SwiftUI

struct RegistrationSuccessView: View {
    let email: String
    @Binding var isLoggedIn: Bool
    @State private var animationFinished = false

    var body: some View {
        ZStack {
            AuthBackground()

            VStack(spacing: 0) {
                Spacer()

                AuthLogo()

                VStack(spacing: 24) {
                    CheckmarkAnimationView {
                        animationFinished = true
                    }
                    .frame(width: 80, height: 80)

                    Text("Inscription réussie !")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .opacity(animationFinished ? 1 : 0)
                        .animation(.easeIn(duration: 0.5).delay(0.5), value: animationFinished)

                    VStack(spacing: 16) {
                        Text("Bienvenue dans la communauté Mangary !")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)

                        VStack(spacing: 8) {
                            Text("Un email de vérification a été envoyé à :")
                                .font(.system(size: 16))
                                .foregroundColor(.white.opacity(0.9))
                                .multilineTextAlignment(.center)

                            Text(email)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(16)
                        }

                        Text("Vérifiez votre boîte email et cliquez sur le lien pour activer votre compte.")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                    }
                    .opacity(animationFinished ? 1 : 0)
                    .animation(.easeIn(duration: 0.5).delay(0.7), value: animationFinished)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 32)

                VStack(spacing: 16) {
                    AuthButton(
                        title: "Continuer vers l'app",
                        action: { isLoggedIn = true }
                    )

                    Button("Renvoyer l'email de vérification") {}
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                        .underline()
                }
                .opacity(animationFinished ? 1 : 0)
                .animation(.easeIn(duration: 0.5).delay(1.3), value: animationFinished)

                Spacer()
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isLoggedIn = true
            }
        }
    }
}

struct CheckmarkAnimationView: View {
    @State private var checkmarkScale: CGFloat = 0
    @State private var circleScale: CGFloat = 0
    @State private var showCheckmark = false

    let onComplete: () -> Void

    var body: some View {
        ZStack {
            Circle()
                .fill(Color(red: 0.749, green: 0.188, blue: 0.188))
                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                .scaleEffect(circleScale)
                .animation(.spring(response: 0.6, dampingFraction: 0.7), value: circleScale)

            Image(systemName: "checkmark")
                .font(.system(size: 32, weight: .heavy))
                .foregroundColor(.white)
                .scaleEffect(checkmarkScale)
                .opacity(showCheckmark ? 1 : 0)
                .animation(.spring(response: 0.4, dampingFraction: 0.6).delay(0.3), value: checkmarkScale)
        }
        .onAppear {
            circleScale = 1.0

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                showCheckmark = true
                checkmarkScale = 1.0
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                onComplete()
            }
        }
    }
}

#Preview {
    RegistrationSuccessView(email: "user@example.com", isLoggedIn: .constant(false))
}