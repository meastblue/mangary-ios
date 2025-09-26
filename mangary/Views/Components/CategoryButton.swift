import SwiftUI

struct CategoryButton: View {
    let category: String
    let onPress: () -> Void

    var body: some View {
        Button(action: onPress) {
            ZStack {
                Image(category)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 180, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.black.opacity(0.4))
                    )

                Text(category)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ZStack {
        Color(red: 0.749, green: 0.188, blue: 0.188)
        CategoryButton(category: "Action", onPress: {})
    }
}