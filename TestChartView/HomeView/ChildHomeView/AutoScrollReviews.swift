import SwiftUI

struct AutoScrollReviews: View {
    let text: String
    let lineLimit: Int = 20
    let font: Font = .system(size: 14, weight: .medium)
    let lineHeight: CGFloat = 20

    @State private var textFits: Bool = true

    var body: some View {
        let maxHeight = CGFloat(lineLimit) * lineHeight

        ZStack {
            TextMeasurer(text: text, font: font, lineSpacing: 2, width: UIScreen.main.bounds.width - 64) { height in

                textFits = height <= maxHeight
            }
            .hidden()

            if textFits {
                Text(text)
                    .font(font)
                    .lineSpacing(2)
                    .foregroundStyle(Color(hex: "28303F"))
                    .padding(12)
                    .background(Color(hex: "FFFFFF"))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
            } else {
                ScrollView(.vertical, showsIndicators: true) {
                    Text(text)
                        .font(font)
                        .lineSpacing(2)
                        .foregroundStyle(Color(hex: "28303F"))
                        .padding(12)
                }
                .frame(height: maxHeight)
                .background(Color(hex: "FFFFFF"))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 20)
                .padding(.top, 16)
            }
        }
    }
}

struct TextMeasurer: View {
    let text: String
    let font: Font
    let lineSpacing: CGFloat
    let width: CGFloat
    let onUpdate: (CGFloat) -> Void

    var body: some View {
        Text(text)
            .font(font)
            .lineSpacing(lineSpacing)
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            onUpdate(proxy.size.height)
                        }
                        .onChange(of: proxy.size.height) { newHeight in
                            onUpdate(newHeight)
                        }
                }
            )
            .frame(width: width)
    }
}

