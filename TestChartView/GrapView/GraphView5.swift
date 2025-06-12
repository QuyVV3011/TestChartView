
import SwiftUI
import UIKit

struct GraphView5: View {
    @Binding var points: [CGPoint]
    @State var onChangeValue: Bool = false
    @State var originOffset: CGFloat = 0
    @State var valueDragOnChange: CGPoint = .zero
    @State var screenWidth: CGFloat = 0
    @State var scroll: SmoothScrollableTrigger = .none
    @State var offset: CGFloat = 0
    
    
    @State var minY: CGFloat = 0
    @State var maxY: CGFloat = 104
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                ZStack {
                    GridLines().frame(height: 104)
                    
                    ScrollCusomView(trigger: $scroll, offset: $offset){
                        ZStack {
                            if !points.isEmpty {
                                colorBottomGraph
                                    .allowsHitTesting(false)
                                
                                curveGraphs
                                
                                pointGraphs
                            }
                        }
                        .padding(.horizontal,(geo.size.width - 30) / 2)
                        .frame(width: (points.last?.x ?? 300) + (geo.size.width - 30), height: maxY)
                    } onScrollEnd: { offsetEnd in
                        guard !points.isEmpty else { return }
                        
                        if let index = points.enumerated().min(by: { abs($0.element.x - offsetEnd) < abs($1.element.x - offsetEnd) })?.offset {
                            scroll = .scroll(offset: points[index].x)
                            offset = offsetEnd
                        }
                    }
                    
                    straightLines.offset(y: 7)
                }
                .frame(height: 120)
                
                VStack {
                    Text("\(Int(maxY))").font(.system(size: 16))
                        .foregroundStyle(Color(hex:"#6B7280"))
                        .position(x: 10,y: 0 )
                    Text("\(Int(maxY + minY) / 2)").font(.system(size: 16))
                        .foregroundStyle(Color(hex:"#6B7280"))
                        .position(x: 10,y: 15 )
                    Text("\(Int(minY))").font(.system(size: 16))
                        .foregroundStyle(Color(hex:"#6B7280"))
                        .position(x: 10,y: 20 )
                }
                .frame(width: 30)
                
            }
            .frame(width: geo.size.width, height: 120)
            .background(Color.white)
            .onChange(of: points, {
                updateMinMaxY()
                scroll = .refresh
            })
            .onAppear {
                screenWidth = geo.size.width - 30
                updateMinMaxY()
            }
        }.frame(height: 120)
        
    }
    
    func updateMinMaxY() {
        if !points.isEmpty && points.count < 2  {
            if points[0].y != 0 {
                minY = points[0].y / 2
                maxY = points[0].y * 2
            } else if points[1].y == 0 {
                minY = points[0].y
                maxY = 100
            }
        } else if !points.isEmpty && points.count > 1 {
            let yValues = points.map { $0.y }
            if let min = yValues.min(), let max = yValues.max() {
                if max == min {
                    minY = min
                    maxY = min * 2
                } else {
                    minY = min
                    maxY = max
                }
            } else {
                minY = 0
                maxY = 100
            }
        }
    }
    
}

extension GraphView5 {
    var pointGraphs: some View {
        ForEach(points.indices, id: \.self) { index in
            Circle()
                .fill(Color.clear)
                .overlay(content: {
                    Circle()
                        .stroke(Color(hex: "#F36084"),lineWidth: 3)
                        .fill((index == points.count - 1 ) ? Color.white : Color(hex: "F36084"))
                        .frame(width:(index == points.count - 1 ) ? 10 : 6, height: (index == points.count - 1) ? 10 : 6)
                })
                .frame(width: 20, height: 20)
                .contentShape(Circle())
                .position(x: points[index].x, y:flippedY(points[index].y))
                .onTapGesture {
                    print("positionClick\(index):\(yPosition(value: points[index].y))")
                }
        }
    }
    
    var colorBottomGraph : some View {
        Path { path in
            if points.count > 1 {
                path.move(to: CGPoint(x: points[0].x, y: maxY))
                path.addLine(to: CGPoint(x: points[0].x, y: flippedY(points[0].y)))
                
                for i in 0..<points.count - 1 {
                    let p1 = points[i]
                    let p2 = points[i + 1]
                    
                    let control1 = CGPoint(x: (p1.x + p2.x) / 2, y: flippedY(p1.y))
                    let control2 = CGPoint(x: (p1.x + p2.x) / 2, y: flippedY(p2.y))
                    
                    path.addCurve(to: CGPoint(x: p2.x, y: flippedY(p2.y)), control1: control1, control2: control2)
                }
                
                path.addLine(to: CGPoint(x: points.last?.x ?? 0, y: maxY))
                path.closeSubpath()
            }
        }
        .fill(LinearGradient(gradient: Gradient(colors: [Color(hex: "#FFFFFF"), Color(hex: "#FFE9EF")]), startPoint: .top, endPoint: .bottom))
    }
    
    var curveGraphs: some View {
        Path { path in
            if points.count > 1 {
                path.move(to: CGPoint(x: points[0].x, y: flippedY(points[0].y)))
                for i in 0..<points.count - 1 {
                    let p1 = points[i]
                    let p2 = points[i + 1]
                    
                    let control1 = CGPoint(x: (p1.x + p2.x) / 2, y: flippedY(p1.y))
                    let control2 = CGPoint(x: (p1.x + p2.x) / 2, y: flippedY(p2.y))
                    
                    path.addCurve(to: CGPoint(x: p2.x, y: flippedY(p2.y)), control1: control1, control2: control2)
                }
            }
        }
        .stroke(Color(hex: "#6B7280"), lineWidth: 1)
        
    }
    
    var straightLines : some View {
        Path { path in
            path.move(to: CGPoint(x: screenWidth / 2, y: 0))
            path.addLine(to: CGPoint(x: screenWidth / 2, y: maxY - 6))
            
            path.move(to: CGPoint(x: screenWidth / 2, y: maxY - 6))
            path.addLine(to: CGPoint(x: screenWidth / 2 - 3, y: maxY))
            path.addLine(to: CGPoint(x: screenWidth / 2 + 3, y: maxY))
            path.closeSubpath()
        }
        .stroke(Color(hex: "#6B7280"), lineWidth: 1)
        .background(
            Path { path in
                path.move(to: CGPoint(x: screenWidth / 2, y: maxY - 6))
                path.addLine(to: CGPoint(x: screenWidth / 2 - 3, y: maxY))
                path.addLine(to: CGPoint(x: screenWidth / 2 + 3, y: maxY))
                path.closeSubpath()
            }
                .fill(Color(hex: "#6B7280"))
        )
    }
    
    func yPosition(value:CGFloat) -> CGFloat {
        guard let maxY = points.map({ $0.y }).max(),
              let minY = points.map({ $0.y }).min(),
              maxY != minY else {
            return 0
        }
        return ((value - minY) / (maxY - minY)) * 104
    }
    
    func flippedY(_ y: CGFloat) -> CGFloat {
        guard maxY != minY else { return 0 }
        let normalizedY = (y - minY) / (maxY - minY)
        return (1 - normalizedY) * 104
    }

}
