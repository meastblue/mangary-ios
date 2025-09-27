import SwiftUI

struct PaginatedGrid: View {
    let categories: [String]
    let onCategoryPress: (String) -> Void

    @State private var currentPage = 0

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 2)

    var body: some View {
        VStack(spacing: 16) {
            TabView(selection: $currentPage) {
                ForEach(0..<pageCount, id: \.self) { pageIndex in
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(categoriesForPage(pageIndex), id: \.self) { category in
                            CategoryButton(
                                category: category,
                                onPress: { onCategoryPress(category) }
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .tag(pageIndex)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 220)

            if pageCount > 1 {
                HStack(spacing: 8) {
                    ForEach(0..<pageCount, id: \.self) { index in
                        Button(action: {
                            currentPage = index
                        }) {
                            Circle()
                                .fill(index == currentPage ? Color("JapanRed") : Color.gray.opacity(0.3))
                                .frame(width: 8, height: 8)
                        }
                    }
                }
            }
        }
    }

    private var pageCount: Int {
        (categories.count + 3) / 4
    }

    private func categoriesForPage(_ page: Int) -> [String] {
        let startIndex = page * 4
        let endIndex = min(startIndex + 4, categories.count)
        return Array(categories[startIndex..<endIndex])
    }
}

#Preview {
    ZStack {
        Color.white
        PaginatedGrid(
            categories: MockData.categories,
            onCategoryPress: { _ in }
        )
    }
}