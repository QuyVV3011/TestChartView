import SwiftUI

struct CustomSliderView: View {
    @Binding var valueCurrent: CGFloat
    @State private var labelWidth: CGFloat = 0
    @State var valueListLevel: [Double] = [0, 12, 24, 37, 86, 231, 520]
    @State var valueListColor: [String] = ["72D59E", "FABA23", "8DE577", "72D59E", "FFD77A", "F7586F"]
    @State var valueListString: [String] = ["Low", "Normal", "BelowAverage", "Average", "AboeAverage", "High"]
    @Binding var showIncrease: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .leading) {
                HStack(spacing: 0) {
                    ForEach(valueListColor.indices,id: \.self) { index in
                        Color(Color(hex: valueListColor[index]))
                            .frame(width: (UIScreen.main.bounds.width - 64) / CGFloat(valueListLevel.count - 1))
                    }
                }
                .frame(height: 9)
                .cornerRadius(12)
                
                HStack(spacing: 0) {
                    ForEach(0..<valueListLevel.count - 1,id: \.self) { index in
                        Text("\(Int(valueListLevel[index]))")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(Color(hex: "6B7280"))
                            .multilineTextAlignment(.leading)
                            .frame(width: (UIScreen.main.bounds.width - 64) / CGFloat(valueListLevel.count - 1))
                            .offset(x: -((UIScreen.main.bounds.width - 64) / CGFloat(valueListLevel.count - 1)) / 2, y: -25)
                    }
                }.overlay {
                    Text("\(Int(valueListLevel[valueListLevel.count - 1]))")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color(hex: "6B7280"))
                        .multilineTextAlignment(.leading)
                        .offset(x: (UIScreen.main.bounds.width - 64) / 2 , y: -25)
                }
                
                Circle()
                    .fill(currentColor)
                    .frame(width: 36, height: 36)
                    .overlay(
                        Text("\(Int(valueCurrent))")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    )
                    .offset(x: mappedOffset(for: valueCurrent, in: (UIScreen.main.bounds.width - 64)) - 18, y: 0)
                    .animation(.easeOut(duration: 1.5), value: valueCurrent)
                
                VStack(spacing: 0) {
                    Image(.icTriangle)
                        .foregroundStyle(Color(hex: "D9D9D9"))
                        .frame(width: 18, height: 15)
                    
                    HStack(spacing: 8) {
                        Text(currentLevel)
                            .font(.system(size: 16, weight: .medium))
                        if showIncrease {
                            Label("-11", systemImage: "arrow.down")
                                .foregroundColor(Color(hex: "72D59E"))
                                .font(.system(size: 12, weight: .medium))
                                .padding(4)
                                .background(Color(hex: "72D59E").opacity(0.15))
                                .cornerRadius(12)
                        }
                        
                    }
                }
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                labelWidth = geo.size.width
                            }
                            .onChange(of: valueCurrent) {
                                labelWidth = geo.size.width
                            }
                    }
                )
                .offset(x: mappedOffset(for: valueCurrent, in: (UIScreen.main.bounds.width - 64)) - labelWidth / 2, y: 40)
                .animation(.easeOut(duration: 1.5), value: valueCurrent)
            }
        }
    }
    
    private var currentColor: Color {
        for (index, _) in valueListLevel.dropLast().enumerated() {
            if valueCurrent < CGFloat(valueListLevel[index + 1]) {
                return Color(hex: valueListColor[index])
            }
        }
        return Color(hex: valueListColor.last ?? "000000")
    }
    
    private var currentLevel: String {
        for (index, _) in valueListLevel.dropLast().enumerated() {
            if valueCurrent < CGFloat(valueListLevel[index + 1]) {
                return valueListString[index]
            }
        }
        return valueListColor.last ?? "Normal"
    }
    
    private func mappedOffset(for val: Double, in totalWidth: CGFloat) -> CGFloat {
        let breakpoints: [Double] = valueListLevel
        let numSections = breakpoints.count - 1
        let sectionWidth = totalWidth / CGFloat(numSections)
        
        for i in 0..<numSections {
            let start = breakpoints[i]
            let end = breakpoints[i + 1]
            if val >= start && val <= end {
                let progress = (val - start) / (end - start)
                return CGFloat(i) * sectionWidth + CGFloat(progress) * sectionWidth
            }
        }
        return 0
    }
    
}

#Preview {
    CustomSliderView(valueCurrent: .constant(70), showIncrease: .constant(false))
}
