import SwiftUI

struct RegisterView: View {
    @Binding var isLoggedIn: Bool
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var acceptTerms = false
    @State private var isLoading = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var navigateToSuccess = false
    @Environment(\.dismiss) private var dismiss

    private var passwordsMatch: Bool {
        password == confirmPassword && !password.isEmpty
    }

    private var isFormValid: Bool {
        !firstName.isEmpty &&
        !lastName.isEmpty &&
        !username.isEmpty &&
        !email.isEmpty &&
        email.contains("@") &&
        password.count >= 8 &&
        passwordsMatch &&
        acceptTerms
    }

    var body: some View {
        ZStack {
            AuthBackground()

            ScrollView {
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 60)

                    AuthLogo(subtitle: "Créer un compte")

                    VStack(spacing: 16) {
                        HStack(spacing: 12) {
                            AppTextField(
                                placeholder: "Prénom",
                                text: $firstName,
                                icon: "person.fill"
                            )

                            AppTextField(
                                placeholder: "Nom",
                                text: $lastName
                            )
                        }

                        AppTextField(
                            placeholder: "Nom d'utilisateur",
                            text: $username,
                            icon: "at",
                            autocapitalization: .never
                        )

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
                            showToggle: true
                        )

                        AppTextField(
                            placeholder: "Confirmer mot de passe",
                            text: $confirmPassword,
                            icon: "lock",
                            isSecure: true,
                            hasError: !passwordsMatch && !confirmPassword.isEmpty,
                            showToggle: true
                        )
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 24)

                    HStack(spacing: 12) {
                        Button {
                            acceptTerms.toggle()
                        } label: {
                            Image(systemName: acceptTerms ? "checkmark.square.fill" : "square")
                                .foregroundColor(acceptTerms ? .white : .white.opacity(0.7))
                                .font(.system(size: 20))
                        }

                        HStack(spacing: 0) {
                            Text("J'accepte les ")
                                .font(.system(size: 14))
                                .foregroundColor(.white.opacity(0.8))

                            Text("conditions d'utilisation")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                                .underline()
                        }

                        Spacer()
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 24)

                    AuthButton(
                        title: "S'inscrire",
                        isLoading: isLoading,
                        isEnabled: isFormValid,
                        action: handleRegister
                    )
                    .padding(.bottom, 24)

                    HStack {
                        Text("Déjà un compte ? ")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.8))

                        Button("Se connecter") {
                            dismiss()
                        }
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .underline()
                    }
                    .padding(.bottom, 60)

                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $navigateToSuccess) {
            RegistrationSuccessView(email: email, isLoggedIn: $isLoggedIn)
                .navigationBarBackButtonHidden(true)
        }
        .alert("Erreur", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }

    private func handleRegister() {
        guard isFormValid else {
            alertMessage = !acceptTerms ? "Veuillez accepter les conditions d'utilisation" : "Veuillez remplir tous les champs correctement"
            showingAlert = true
            return
        }

        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
            navigateToSuccess = true
        }
    }
}

#Preview {
    NavigationStack {
        RegisterView(isLoggedIn: .constant(false))
    }
}