import SwiftUI

struct ForgotPasswordView: View {
    @State private var email = ""
    @State private var isLoading = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var navigateToEmailSent = false
    @Environment(\.dismiss) private var dismiss

    private var isValidEmail: Bool {
        !email.isEmpty && email.contains("@") && email.contains(".")
    }

    var body: some View {
        ZStack {
            AuthBackground()

            VStack(spacing: 0) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding(.horizontal, 32)
                .padding(.top, 20)

                Spacer()

                AuthLogo()

                VStack(spacing: 12) {
                    Text("Mot de passe oublié")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(.white)

                    Text("Entrez votre adresse email pour recevoir un lien de réinitialisation")
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 32)

                AppTextField(
                    placeholder: "Votre adresse email",
                    text: $email,
                    icon: "envelope",
                    keyboardType: .emailAddress,
                    autocapitalization: .never
                )
                .padding(.horizontal, 32)
                .padding(.bottom, 32)

                AuthButton(
                    title: "Envoyer le lien",
                    isLoading: isLoading,
                    isEnabled: isValidEmail,
                    action: handleSubmit
                )

                Spacer()
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $navigateToEmailSent) {
            EmailSentView(email: email)
                .navigationBarBackButtonHidden(true)
        }
        .alert("Erreur", isPresented: $showingAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
    }

    private func handleSubmit() {
        guard isValidEmail else {
            alertMessage = "Veuillez entrer une adresse email valide"
            showingAlert = true
            return
        }

        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isLoading = false
            navigateToEmailSent = true
        }
    }
}

#Preview {
    NavigationStack {
        ForgotPasswordView()
    }
}