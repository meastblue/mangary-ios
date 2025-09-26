import SwiftUI

struct EmailSentView: View {
    let email: String
    @Environment(\.dismiss) private var dismiss
    @State private var envelopeScale: CGFloat = 0
    @State private var envelopeRotation: Double = 0
    @State private var showContent = false

    var body: some View {
        ZStack {
            AuthBackground()

            VStack(spacing: 0) {
                Spacer()

                AuthLogo()

                AnimatedEnvelopeView(
                    scale: $envelopeScale,
                    rotation: $envelopeRotation
                ) {
                    showContent = true
                }
                .frame(width: 80, height: 80)
                .padding(.bottom, 32)

                VStack(spacing: 12) {
                    Text("Email envoyé !")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .opacity(showContent ? 1 : 0)
                        .animation(.easeIn(duration: 0.5).delay(0.5), value: showContent)

                    Text("Nous avons envoyé un lien de réinitialisation à :")
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .opacity(showContent ? 1 : 0)
                        .animation(.easeIn(duration: 0.5).delay(0.7), value: showContent)
                }
                .padding(.bottom, 24)

                Text(email)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(16)
                    .padding(.bottom, 24)
                    .opacity(showContent ? 1 : 0)
                    .scaleEffect(showContent ? 1 : 0.8)
                    .animation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.9), value: showContent)

                Text("Vérifiez votre boîte email (et vos spams) puis suivez les instructions pour créer un nouveau mot de passe.")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 32)
                    .opacity(showContent ? 1 : 0)
                    .animation(.easeIn(duration: 0.5).delay(1.1), value: showContent)

                VStack(spacing: 16) {
                    AuthButton(
                        title: "Retour à la connexion",
                        action: handleBackToLogin
                    )
                    .opacity(showContent ? 1 : 0)
                    .offset(y: showContent ? 0 : 20)
                    .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(1.3), value: showContent)

                    Button("Renvoyer l'email") {}
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                        .underline()
                        .opacity(showContent ? 1 : 0)
                        .animation(.easeIn(duration: 0.5).delay(1.5), value: showContent)
                }

                Spacer()
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            startAnimation()
        }
    }

    private func startAnimation() {
        withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
            envelopeScale = 1.0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut(duration: 0.4)) {
                envelopeRotation = 5
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            withAnimation(.easeInOut(duration: 0.3)) {
                envelopeRotation = 0
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                showContent = true
            }
        }
    }

    private func handleBackToLogin() {
        dismiss()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            dismiss()
        }
    }
}

struct AnimatedEnvelopeView: View {
    @Binding var scale: CGFloat
    @Binding var rotation: Double
    let onComplete: () -> Void
    @State private var badgePulse: CGFloat = 1.0

    var body: some View {
        ZStack {
            Image(systemName: "envelope.fill")
                .font(.system(size: 60))
                .foregroundColor(.white)
                .scaleEffect(scale)
                .rotationEffect(.degrees(rotation))
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 24))
                .foregroundColor(.green)
                .background(Color.white.clipShape(Circle()))
                .scaleEffect(badgePulse)
                .offset(x: 20, y: -15)
                .opacity(scale > 0.8 ? 1 : 0)
                .animation(.easeInOut(duration: 0.3).delay(0.4), value: scale)
        }
        .onChange(of: scale) {
            if scale > 0.8 {
                withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                    badgePulse = 1.2
                }
            }
        }
    }
}

#Preview {
    EmailSentView(email: "user@example.com")
}