import SwiftUI

struct ReadingCarouselView: View {
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
                        subtitle: "\(item.progress ?? 0)% lu",
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
        ReadingCarouselView(
            items: MockData.generateReadingManga(count: 4),
            itemsPerPage: 3,
            itemWidth: 110,
            itemHeight: 160,
            onCardPress: { _ in }
        )
    }
}