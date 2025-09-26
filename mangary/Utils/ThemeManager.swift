import SwiftUI
import Combine

class ThemeManager: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }

    var colorScheme: ColorScheme {
        isDarkMode ? .dark : .light
    }

    var backgroundColor: Color {
        isDarkMode ? Color.black : Color.white
    }

    var surfaceColor: Color {
        isDarkMode ? Color(red: 0.11, green: 0.11, blue: 0.12) : Color.white
    }

    var primaryTextColor: Color {
        isDarkMode ? Color.white : Color.black
    }

    var secondaryTextColor: Color {
        isDarkMode ? Color.gray : Color.gray
    }

    var cardBackgroundColor: Color {
        isDarkMode ? Color(red: 0.15, green: 0.15, blue: 0.16).opacity(0.8) : Color.white.opacity(0.8)
    }

    var borderColor: Color {
        isDarkMode ? Color.gray.opacity(0.3) : Color.gray.opacity(0.2)
    }

    var floatingElementLight: Color {
        isDarkMode ? Color.white.opacity(0.02) : Color.white.opacity(0.05)
    }

    var floatingElementDark: Color {
        isDarkMode ? Color.gray.opacity(0.05) : Color.gray.opacity(0.1)
    }

    func toggleTheme() {
        isDarkMode.toggle()
    }
}