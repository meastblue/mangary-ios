import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var navigateToRegister = false
    @State private var navigateToForgotPassword = false

    private var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty
    }

    var body: some View {
        ZStack {
            AuthBackground()

            VStack(spacing: 0) {
                Spacer()

                AuthLogo()

                VStack(spacing: 20) {
                    AppTextField(
                        placeholder: "Email",
                        text: $email,
                        icon: "envelope",
                        keyboardType: .emailAddress,
                        autocapitalization: .never
                    )

                    AppTextField(
                        placeholder: "Mot de passe",
                        text: $password,
                        icon: "lock",
                        isSecure: true,
                        autocapitalization: .never
                    )
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 32)

                HStack {
                    Spacer()
                    Button("Mot de passe oublié ?") {
                        navigateToForgotPassword = true
                    }
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.9))
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 32)

                AuthButton(
                    title: "Connexion",
                    isLoading: isLoading,
                    isEnabled: isFormValid,
                    action: handleLogin
                )
                .padding(.bottom, 32)

                HStack {
                    Rectangle()
                        .fill(Color.white.opacity(0.3))
                        .frame(height: 1)

                    Text("OU")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.horizontal, 16)

                    Rectangle()
                        .fill(Color.white.opacity(0.3))
                        .frame(height: 1)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 32)

                VStack(spacing: 20) {
                    SocialButton(
                        title: "Continuer avec Apple",
                        iconName: "Apple",
                        backgroundColor: .black,
                        textColor: .white,
                        action: handleAppleSignIn
                    )

                    SocialButton(
                        title: "Continuer avec Google",
                        iconName: "Google",
                        backgroundColor: .white,
                        textColor: .black,
                        action: handleGoogleSignIn
                    )
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 32)

                HStack {
                    Text("Pas encore de compte ? ")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.8))

                    Button("S'inscrire") {
                        navigateToRegister = true
                    }
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .underline()
                }

                Spacer()
            }
        }
        .navigationDestination(isPresented: $navigateToRegister) {
            RegisterView(isLoggedIn: $isLoggedIn)
                .navigationBarBackButtonHidden(true)
        }
        .navigationDestination(isPresented: $navigateToForgotPassword) {
            ForgotPasswordView()
                .navigationBarBackButtonHidden(true)
        }
        .alert("Erreur", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }

    private func handleLogin() {
        guard isFormValid else {
            alertMessage = "Veuillez remplir tous les champs"
            showingAlert = true
            return
        }

        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false

            if email.contains("@") && !password.isEmpty {
                isLoggedIn = true
            } else {
                alertMessage = "Email ou mot de passe invalide"
                showingAlert = true
            }
        }
    }

    private func handleAppleSignIn() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isLoading = false
            isLoggedIn = true
        }
    }

    private func handleGoogleSignIn() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isLoading = false
            isLoggedIn = true
        }
    }
}

#Preview {
    NavigationStack {
        LoginView(isLoggedIn: .constant(false))
    }
}
