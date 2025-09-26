import SwiftUI

struct AuthButton: View {
    let title: String
    let isLoading: Bool
    let isEnabled: Bool
    let action: () -> Void

    init(title: String, isLoading: Bool = false, isEnabled: Bool = true, action: @escaping () -> Void) {
        self.title = title
        self.isLoading = isLoading
        self.isEnabled = isEnabled
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color(red: 0.745, green: 0.184, blue: 0.184)))
                        .scaleEffect(0.8)
                } else {
                    Text(title)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color(red: 0.745, green: 0.184, blue: 0.184))
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 8)
        .disabled(!isEnabled || isLoading)
        .opacity(isEnabled ? 1.0 : 0.7)
        .padding(.horizontal, 32)
    }
}

#Preview {
    ZStack {
        AuthBackground()
        VStack {
            AuthButton(title: "Connexion", isEnabled: true) {}
            AuthButton(title: "Loading...", isLoading: true) {}
            AuthButton(title: "Disabled", isEnabled: false) {}
        }
    }
}