import SwiftUI

struct SettingsView: View {
    @Binding var isLoggedIn: Bool
    @State private var showingLogoutAlert = false
    @State private var notificationsEnabled = true
    @State private var hasNotifications = false
    @StateObject private var themeManager = ThemeManager()

    var body: some View {
        AnimatedThemeView(useBackground: true) {
            ZStack {
                AnimatedThemeView(useSurface: true)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 0) {
                        HeaderView(
                            onNotificationPress: handleNotificationPress,
                            hasNotifications: hasNotifications
                        )

                        VStack(spacing: 32) {
                            accountSection
                            notificationsSection
                            themeSection
                            aboutSection

                            separator

                            logoutButton
                        }
                        .padding(.top, 16)
                        .padding(.bottom, 32)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .alert("Se déconnecter", isPresented: $showingLogoutAlert) {
            Button("Annuler", role: .cancel) {}
            Button("Se déconnecter", role: .destructive) {
                isLoggedIn = false
            }
        } message: {
            Text("Êtes-vous sûr de vouloir vous déconnecter ?")
        }
    }

    private func renderFloatingElements() -> some View {
        ZStack {
            AnimatedThemeView(
                lightColor: themeManager.floatingElementLight,
                darkColor: themeManager.floatingElementDark,
                width: 192,
                height: 192,
                cornerRadius: 96
            )
            .offset(x: -48, y: -96)

            AnimatedThemeView(
                lightColor: themeManager.floatingElementLight,
                darkColor: themeManager.floatingElementDark,
                width: 256,
                height: 256,
                cornerRadius: 128
            )
            .offset(x: 64, y: 128)

            AnimatedThemeView(
                lightColor: themeManager.floatingElementLight,
                darkColor: themeManager.floatingElementDark,
                width: 208,
                height: 208,
                cornerRadius: 104
            )
            .offset(x: 16, y: 320)
        }
    }

    private var accountSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            AnimatedText(
                "Compte",
                fontSize: 20,
                fontWeight: .semibold
            )
            .padding(.horizontal, 20)

            VStack(spacing: 12) {
                settingCard(
                    icon: "person.circle",
                    title: "Profil",
                    subtitle: "Modifier vos informations",
                    action: { print("Profile pressed") }
                )

                settingCard(
                    icon: "envelope",
                    title: "Email",
                    subtitle: "user@example.com",
                    action: { print("Email pressed") }
                )

                settingCard(
                    icon: "lock",
                    title: "Mot de passe",
                    subtitle: "Changer votre mot de passe",
                    action: { print("Password pressed") }
                )
            }
        }
    }

    private var notificationsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            AnimatedText(
                "Notifications",
                fontSize: 20,
                fontWeight: .semibold
            )
            .padding(.horizontal, 20)

            settingCardWithToggle(
                icon: "bell",
                title: "Notifications push",
                subtitle: "Recevoir les notifications",
                isOn: $notificationsEnabled,
                onChange: { value in
                    notificationsEnabled = value
                    hasNotifications = value
                }
            )
        }
    }

    private var themeSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            AnimatedText(
                "Thème",
                fontSize: 20,
                fontWeight: .semibold
            )
            .padding(.horizontal, 20)

            settingCardWithToggle(
                icon: themeManager.isDarkMode ? "moon.fill" : "moon",
                title: "Mode sombre",
                subtitle: "Interface sombre pour la lecture",
                isOn: Binding(
                    get: { themeManager.isDarkMode },
                    set: { themeManager.isDarkMode = $0 }
                ),
                onChange: { value in
                    themeManager.isDarkMode = value
                }
            )
        }
    }

    private var aboutSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            AnimatedText(
                "À propos",
                fontSize: 20,
                fontWeight: .semibold
            )
            .padding(.horizontal, 20)

            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(themeManager.cardBackgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(themeManager.borderColor, lineWidth: 1)
                    )
                    .frame(height: 64)
                    .overlay(
                        HStack {
                            HStack(spacing: 16) {
                                Image(systemName: "info.circle")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color("JapanRed"))
                                    .frame(width: 32, height: 32)

                                VStack(alignment: .leading, spacing: 2) {
                                    AnimatedText(
                                        "Version de l'app",
                                        fontSize: 16,
                                        fontWeight: .medium
                                    )

                                    AnimatedText(
                                        "1.0.0 (Build 1)",
                                        fontSize: 14,
                                        useSecondaryTextColor: true
                                    )
                                }

                                Spacer()
                            }
                            .padding(.horizontal, 16)
                        }
                    )
                    .padding(.horizontal, 20)
            }
        }
    }

    private var separator: some View {
        Rectangle()
            .fill(themeManager.borderColor)
            .frame(height: 1)
            .padding(.horizontal, 20)
    }

    private var logoutButton: some View {
        Button(action: { showingLogoutAlert = true }) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.red.opacity(0.9))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.red.opacity(0.2), lineWidth: 1)
                )
                .frame(height: 64)
                .overlay(
                    HStack {
                        Image(systemName: "arrow.backward.circle")
                            .font(.system(size: 18))
                            .foregroundColor(.white)

                        AnimatedText(
                            "Se déconnecter",
                            fontSize: 16,
                            fontWeight: .semibold,
                            customColor: .white
                        )
                    }
                )
                .padding(.horizontal, 20)
        }
        .scaleEffect(1.0)
    }

    private func settingCard(
        icon: String,
        title: String,
        subtitle: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: 12)
                .fill(themeManager.cardBackgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(themeManager.borderColor, lineWidth: 1)
                )
                .frame(height: 64)
                .overlay(
                    HStack {
                        HStack(spacing: 16) {
                            Image(systemName: icon)
                                .font(.system(size: 20))
                                .foregroundColor(Color("JapanRed"))
                                .frame(width: 32, height: 32)

                            VStack(alignment: .leading, spacing: 2) {
                                AnimatedText(
                                    title,
                                    fontSize: 16,
                                    fontWeight: .medium
                                )

                                AnimatedText(
                                    subtitle,
                                    fontSize: 14,
                                    useSecondaryTextColor: true
                                )
                            }

                            Spacer()

                            Image(systemName: "chevron.right")
                                .font(.system(size: 16))
                                .foregroundColor(themeManager.secondaryTextColor)
                        }
                        .padding(.horizontal, 16)
                    }
                )
                .padding(.horizontal, 20)
        }
        .buttonStyle(PlainButtonStyle())
    }

    private func settingCardWithToggle(
        icon: String,
        title: String,
        subtitle: String,
        isOn: Binding<Bool>,
        onChange: @escaping (Bool) -> Void
    ) -> some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(themeManager.cardBackgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(themeManager.borderColor, lineWidth: 1)
            )
            .frame(height: 64)
            .overlay(
                HStack {
                    HStack(spacing: 16) {
                        Image(systemName: icon)
                            .font(.system(size: 20))
                            .foregroundColor(Color("JapanRed"))
                            .frame(width: 32, height: 32)

                        VStack(alignment: .leading, spacing: 2) {
                            AnimatedText(
                                title,
                                fontSize: 16,
                                fontWeight: .medium
                            )

                            AnimatedText(
                                subtitle,
                                fontSize: 14,
                                useSecondaryTextColor: true
                            )
                        }

                        Spacer()

                        Toggle("", isOn: isOn)
                            .toggleStyle(SwitchToggleStyle(tint: Color("JapanRed")))
                            .onChange(of: isOn.wrappedValue) {
                                onChange(isOn.wrappedValue)
                            }
                    }
                    .padding(.horizontal, 16)
                }
            )
            .padding(.horizontal, 20)
    }

    private func handleNotificationPress() {
        print("Notification pressed")
    }
}

#Preview {
    SettingsView(isLoggedIn: .constant(true))
}