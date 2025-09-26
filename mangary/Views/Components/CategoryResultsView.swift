import SwiftUI

struct CategoryResultsView: View {
    let category: String
    let onBackPress: () -> Void
    @StateObject private var themeManager = ThemeManager()

    private let mockResults = MockData.generateManga(count: 12)
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Button(action: onBackPress) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(Color("JapanRed"))
                        .clipShape(Circle())
                }

                Text(category)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(themeManager.primaryTextColor)

                Spacer()
            }
            .padding(.horizontal, 20)

            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(mockResults) { item in
                        MangaCard(
                            title: item.title,
                            imageUrl: item.imageUrl,
                            width: 110,
                            height: 160,
                            onPress: { print("Pressed: \(item.title)") }
                        )
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.white
        CategoryResultsView(
            category: "Action",
            onBackPress: {}
        )
    }
}