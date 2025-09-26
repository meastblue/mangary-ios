import SwiftUI

struct MangaCarouselView: View {
    let items: [MangaItem]
    let itemsPerPage: Int
    let itemWidth: CGFloat
    let itemHeight: CGFloat
    let onCardPress: (Int) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(items) { item in
                    MangaCard(
                        title: item.title,
                        imageUrl: item.imageUrl,
                        width: itemWidth,
                        height: itemHeight,
                        onPress: { onCardPress(item.id) }
                    )
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    ZStack {
        Color(red: 0.749, green: 0.188, blue: 0.188)
        MangaCarouselView(
            items: MockData.generateManga(count: 6),
            itemsPerPage: 3,
            itemWidth: 110,
            itemHeight: 160,
            onCardPress: { _ in }
        )
    }
}