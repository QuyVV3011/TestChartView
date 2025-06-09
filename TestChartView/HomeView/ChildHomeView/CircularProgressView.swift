import SwiftUI

struct CircularProgressView: View {
    @State var progress: Double
    @State var label: String
    @State var valueText: Int
    @State var valueType: String
    @State var color: Color
    let visibleCirclePortion: Double = 0.8

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: visibleCirclePortion)
                .stroke(color.opacity(0.2), style: StrokeStyle(lineWidth: 12, lineCap: .round))
                .rotationEffect(.degrees(127))
            Circle()
                .trim(from: 0, to: progress * visibleCirclePortion)
                .stroke(color, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                .rotationEffect(.degrees(127))

            VStack {
                Text(label)
                    .font(.headline)
                    .foregroundColor(color)

                Text("\(valueText)\(valueType)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 90, height: 90)
    }
}


