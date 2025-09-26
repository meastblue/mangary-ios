import SwiftUI

struct AppTextField: View {
    let placeholder: String
    @Binding var text: String
    var icon: String? = nil
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default
    var autocapitalization: TextInputAutocapitalization = .sentences
    var hasError: Bool = false
    var showToggle: Bool = false
    @State private var isSecureVisible: Bool = false

    init(
        placeholder: String,
        text: Binding<String>,
        icon: String? = nil,
        isSecure: Bool = false,
        keyboardType: UIKeyboardType = .default,
        autocapitalization: TextInputAutocapitalization = .sentences,
        hasError: Bool = false,
        showToggle: Bool = false
    ) {
        self.placeholder = placeholder
        self._text = text
        self.icon = icon
        self.isSecure = isSecure
        self.keyboardType = keyboardType
        self.autocapitalization = autocapitalization
        self.hasError = hasError
        self.showToggle = showToggle || isSecure // Auto-enable toggle for secure fields
    }

    var body: some View {
        HStack(spacing: 12) { // flex-row items-center
            // Icon (optional)
            if let icon = icon {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(Color.white.opacity(0.7)) // rgba(255, 255, 255, 0.7)
                    .frame(width: 20, height: 20)
            }

            // Text field - text-white text-base flex-1 ml-3
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.white.opacity(0.7))
                        .font(.system(size: 16))
                }

                if isSecure && !isSecureVisible {
                    SecureField("", text: $text)
                        .keyboardType(keyboardType)
                        .textInputAutocapitalization(autocapitalization)
                        .foregroundColor(.white) // text-white
                        .font(.system(size: 16)) // text-base
                        .frame(maxWidth: .infinity) // flex-1
                } else {
                    TextField("", text: $text)
                        .keyboardType(keyboardType)
                        .textInputAutocapitalization(autocapitalization)
                        .foregroundColor(.white) // text-white
                        .font(.system(size: 16)) // text-base
                        .frame(maxWidth: .infinity) // flex-1
                }
            }

            // Toggle button for secure fields
            if showToggle && isSecure {
                Button(action: {
                    isSecureVisible.toggle()
                }) {
                    Image(systemName: isSecureVisible ? "eye" : "eye.slash")
                        .font(.system(size: 20))
                        .foregroundColor(Color.white.opacity(0.7)) // rgba(255, 255, 255, 0.7)
                        .frame(width: 20, height: 20)
                }
            }
        }
        .padding(.horizontal, 20) // px-5
        .padding(.vertical, 16) // py-4
        .background(Color.white.opacity(0.2)) // bg-white/20
        .cornerRadius(16) // rounded-2xl
        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3) // shadow-md
    }
}

extension UIKeyboardType {
    var swiftUIKeyboardType: UIKeyboardType {
        return self
    }
}

#Preview {
    VStack(spacing: 20) {
        AppTextField(
            placeholder: "Email",
            text: .constant(""),
            icon: "envelope",
            keyboardType: .emailAddress,
            autocapitalization: .never
        )

        AppTextField(
            placeholder: "Mot de passe",
            text: .constant(""),
            icon: "lock",
            isSecure: true
        )

        AppTextField(
            placeholder: "Prénom",
            text: .constant(""),
            icon: "person"
        )
    }
    .padding()
    .background(
        Color(red: 0.745, green: 0.184, blue: 0.184)
    )
}