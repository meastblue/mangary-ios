import SwiftUI

struct CarouselView<Content: View>: View {
    let content: Content

    let itemsPerPage: ItemsPerPage
    let columns: Int
    let rows: Int

    let pageWidth: PageWidth
    let itemWidth: ItemWidth
    let itemHeight: CGFloat?

    let gap: CGFloat
    let horizontalSpacing: CGFloat?
    let verticalSpacing: CGFloat?
    let contentPadding: CGFloat
    let pageSpacing: CGFloat

    let showPagination: Bool
    let paginationPosition: PaginationPosition
    let activeDotColor: Color
    let inactiveDotColor: Color
    let dotSize: CGFloat

    let snapToPage: Bool
    let enableScroll: Bool
    let autoplay: Bool
    let autoplayInterval: TimeInterval

    let onPageChange: ((Int) -> Void)?

    @State private var currentPage: Int = 0
    @State private var timer: Timer?

    enum ItemsPerPage {
        case auto
        case count(Int)
    }

    enum PageWidth {
        case full
        case fixed(CGFloat)
    }

    enum ItemWidth {
        case auto
        case fixed(CGFloat)
    }

    enum PaginationPosition {
        case top, bottom, none
    }

    init(
        itemsPerPage: ItemsPerPage = .count(4),
        columns: Int = 2,
        rows: Int = 2,
        pageWidth: PageWidth = .full,
        itemWidth: ItemWidth = .auto,
        itemHeight: CGFloat? = nil,
        gap: CGFloat = 12,
        horizontalSpacing: CGFloat? = nil,
        verticalSpacing: CGFloat? = nil,
        contentPadding: CGFloat = 24,
        pageSpacing: CGFloat = 24,
        showPagination: Bool = true,
        paginationPosition: PaginationPosition = .bottom,
        activeDotColor: Color = Color("JapanRed"),
        inactiveDotColor: Color = Color.gray.opacity(0.3),
        dotSize: CGFloat = 8,
        snapToPage: Bool = true,
        enableScroll: Bool = true,
        autoplay: Bool = false,
        autoplayInterval: TimeInterval = 3.0,
        onPageChange: ((Int) -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.itemsPerPage = itemsPerPage
        self.columns = columns
        self.rows = rows
        self.pageWidth = pageWidth
        self.itemWidth = itemWidth
        self.itemHeight = itemHeight
        self.gap = gap
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.contentPadding = contentPadding
        self.pageSpacing = pageSpacing
        self.showPagination = showPagination
        self.paginationPosition = paginationPosition
        self.activeDotColor = activeDotColor
        self.inactiveDotColor = inactiveDotColor
        self.dotSize = dotSize
        self.snapToPage = snapToPage
        self.enableScroll = enableScroll
        self.autoplay = autoplay
        self.autoplayInterval = autoplayInterval
        self.onPageChange = onPageChange
    }

    var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    var calculatedPageWidth: CGFloat {
        switch pageWidth {
        case .full:
            return screenWidth - (contentPadding * 2)
        case .fixed(let width):
            return width
        }
    }

    var isAutoMode: Bool {
        switch itemsPerPage {
        case .auto:
            return true
        case .count(_):
            return false
        }
    }

    var actualItemsPerPage: Int {
        switch itemsPerPage {
        case .auto:
            return Int.max
        case .count(let count):
            return count
        }
    }

    var hSpacing: CGFloat {
        horizontalSpacing ?? gap
    }

    var vSpacing: CGFloat {
        verticalSpacing ?? gap
    }

    var calculatedItemWidth: CGFloat? {
        switch itemWidth {
        case .auto:
            if isAutoMode {
                return nil
            }
            let availableWidth = calculatedPageWidth - (hSpacing * CGFloat(columns - 1))
            return availableWidth / CGFloat(columns)
        case .fixed(let width):
            return width
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            if paginationPosition == .top {
                renderPagination()
            }

            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: isAutoMode ? hSpacing : pageSpacing) {
                        content
                    }
                    .padding(.horizontal, contentPadding)
                }
                .scrollDisabled(!enableScroll)
                .onAppear {
                    startAutoplay()
                }
                .onDisappear {
                    stopAutoplay()
                }
            }

            if paginationPosition == .bottom {
                renderPagination()
            }
        }
    }

    @ViewBuilder
    private func renderPagination() -> some View {
        if showPagination && !isAutoMode && paginationPosition != .none {
            HStack(spacing: 8) {
                ForEach(0..<totalPages, id: \.self) { index in
                    Button(action: {
                        goToPage(index)
                    }) {
                        Circle()
                            .fill(index == currentPage ? activeDotColor : inactiveDotColor)
                            .frame(width: dotSize, height: dotSize)
                    }
                    .disabled(!snapToPage)
                }
            }
            .padding(.top, paginationPosition == .bottom ? 16 : 0)
            .padding(.bottom, paginationPosition == .top ? 16 : 0)
        }
    }

    private var totalPages: Int {
        return 1
    }

    private func goToPage(_ index: Int) {
        currentPage = index
        onPageChange?(index)
    }

    private func startAutoplay() {
        guard autoplay && totalPages > 1 else { return }

        timer = Timer.scheduledTimer(withTimeInterval: autoplayInterval, repeats: true) { _ in
            let nextPage = (currentPage + 1) % totalPages
            goToPage(nextPage)
        }
    }

    private func stopAutoplay() {
        timer?.invalidate()
        timer = nil
    }
}

struct HorizontalCarousel<Content: View>: View {
    let content: Content
    let itemWidth: CGFloat
    let itemHeight: CGFloat
    let gap: CGFloat

    init(
        itemWidth: CGFloat = 110,
        itemHeight: CGFloat = 160,
        gap: CGFloat = 12,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.itemWidth = itemWidth
        self.itemHeight = itemHeight
        self.gap = gap
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: gap) {
                content
            }
            .padding(.horizontal, 20)
        }
        .frame(height: itemHeight)
    }
}

struct PaginatedCarousel<Content: View>: View {
    let content: Content
    let itemsPerPage: Int
    let columns: Int
    let rows: Int
    let itemWidth: CGFloat
    let itemHeight: CGFloat
    let gap: CGFloat
    let showPagination: Bool
    let activeDotColor: Color
    let inactiveDotColor: Color
    let onPageChange: ((Int) -> Void)?

    @State private var currentPage: Int = 0

    init(
        itemsPerPage: Int = 4,
        columns: Int = 2,
        rows: Int = 2,
        itemWidth: CGFloat = 160,
        itemHeight: CGFloat = 100,
        gap: CGFloat = 12,
        showPagination: Bool = true,
        activeDotColor: Color = Color("JapanRed"),
        inactiveDotColor: Color = Color.gray.opacity(0.3),
        onPageChange: ((Int) -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.itemsPerPage = itemsPerPage
        self.columns = columns
        self.rows = rows
        self.itemWidth = itemWidth
        self.itemHeight = itemHeight
        self.gap = gap
        self.showPagination = showPagination
        self.activeDotColor = activeDotColor
        self.inactiveDotColor = inactiveDotColor
        self.onPageChange = onPageChange
    }

    var body: some View {
        VStack(spacing: 16) {
            TabView(selection: $currentPage) {
                content
                    .tag(0)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: CGFloat(rows) * itemHeight + CGFloat(rows - 1) * gap)

            if showPagination {
                HStack(spacing: 8) {
                    ForEach(0..<2, id: \.self) { index in
                        Button(action: {
                            currentPage = index
                            onPageChange?(index)
                        }) {
                            Circle()
                                .fill(index == currentPage ? activeDotColor : inactiveDotColor)
                                .frame(width: 8, height: 8)
                        }
                    }
                }
            }
        }
        .onChange(of: currentPage) {
            onPageChange?(currentPage)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        HorizontalCarousel(
            itemWidth: 110,
            itemHeight: 160,
            gap: 12
        ) {
            ForEach(0..<6, id: \.self) { index in
                Rectangle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(width: 110, height: 160)
                    .overlay(
                        Text("\(index)")
                            .font(.title)
                            .foregroundColor(.white)
                    )
            }
        }

        PaginatedCarousel(
            itemsPerPage: 4,
            columns: 2,
            rows: 2,
            showPagination: true
        ) {
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2),
                spacing: 12
            ) {
                ForEach(0..<4, id: \.self) { index in
                    Rectangle()
                        .fill(Color.red.opacity(0.3))
                        .frame(width: 160, height: 100)
                        .overlay(
                            Text("\(index)")
                                .font(.title)
                                .foregroundColor(.white)
                        )
                }
            }
            .padding(.horizontal, 20)
        }
    }
    .padding()
}