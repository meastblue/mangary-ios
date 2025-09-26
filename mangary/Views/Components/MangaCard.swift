import SwiftUI

struct MangaCard: View {
    let title: String
    let imageUrl: String
    let subtitle: String?
    let width: CGFloat
    let height: CGFloat
    let onPress: () -> Void

    init(
        title: String,
        imageUrl: String,
        subtitle: String? = nil,
        width: CGFloat = 110,
        height: CGFloat = 160,
        onPress: @escaping () -> Void
    ) {
        self.title = title
        self.imageUrl = imageUrl
        self.subtitle = subtitle
        self.width = width
        self.height = height
        self.onPress = onPress
    }

    var body: some View {
        Button(action: onPress) {
            VStack(alignment: .leading, spacing: 8) {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                }
                .frame(width: width, height: height * 0.8)
                .clipShape(RoundedRectangle(cornerRadius: 8))

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white)
                        .lineLimit(2)

                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.system(size: 10))
                            .foregroundColor(.white.opacity(0.7))
                            .lineLimit(1)
                    }
                }
                .frame(width: width, alignment: .leading)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ZStack {
        Color(red: 0.749, green: 0.188, blue: 0.188)
        HStack {
            MangaCard(
                title: "One Piece",
                imageUrl: "https://picsum.photos/200/300",
                onPress: {}
            )

            MangaCard(
                title: "Naruto",
                imageUrl: "https://picsum.photos/200/300",
                subtitle: "85% lu",
                onPress: {}
            )
        }
        .padding()
    }
}