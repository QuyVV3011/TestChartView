
import SwiftUI
import UIKit

struct GraphView2: View {
    @State private var points: [CGPoint] = [
        CGPoint(x: 0, y: 80),
        CGPoint(x: 50, y: 10),
        CGPoint(x: 100, y: 80),
        CGPoint(x: 150, y: 20),
        CGPoint(x: 200, y: 50),
        CGPoint(x: 250, y: 104),
        CGPoint(x: 300, y: 20),
        CGPoint(x: 350, y: 20),
        CGPoint(x: 400, y: 20),
        CGPoint(x: 450, y: 20),
        CGPoint(x: 500, y: 20),
        CGPoint(x: 550, y: 0),
        CGPoint(x: 600, y: 0),
        CGPoint(x: 650, y: 20),
        CGPoint(x: 700, y: 20),
        
    ]
    @State private var pointsBlue: [CGPoint] = [
        CGPoint(x: 0, y: 60),
        CGPoint(x: 50, y: 5),
        CGPoint(x: 100, y: 40),
        CGPoint(x: 150, y: 10),
        CGPoint(x: 200, y: 20),
        CGPoint(x: 250, y: 90),
        CGPoint(x: 300, y: 10),
        CGPoint(x: 350, y: 10),
        CGPoint(x: 400, y: 10),
        CGPoint(x: 450, y: 10),
        CGPoint(x: 500, y: 10),
        CGPoint(x: 550, y: 0),
        CGPoint(x: 600, y: 0),
        CGPoint(x: 650, y: 40),
        CGPoint(x: 700, y: 40),
        
    ]
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
                                
                                curveGraphs(points: points)
                                curveGraphs(points: pointsBlue)
                                
                                pointGraphs(points: points,color: Color(hex: "#F36084"))
                                pointGraphs(points: pointsBlue, color: Color(hex: "3685F5"))
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
                    Text("\(Int((maxY + minY)/2))").font(.system(size: 16))
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

extension GraphView2 {
    func pointGraphs(points: [CGPoint],color: Color) -> some View {
        ForEach(points.indices, id: \.self) { index in
            Circle()
                .fill(Color.clear)
                .overlay(content: {
                    Circle()
                        .stroke(color, lineWidth: 3)
                        .fill((index == points.count - 1 ) ? Color.white : color)
                        .frame(width:(index == points.count - 1 ) ? 10 : 6, height: (index == points.count - 1) ? 10 : 6)
                })
                .frame(width: 20, height: 20)
                .contentShape(Circle())
                .position(x: points[index].x, y: flippedY(points[index].y))
                .onTapGesture {
                    
                }
        }
    }
    
    func curveGraphs(points: [CGPoint]) -> some View {
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
    
    func flippedY(_ y: CGFloat) -> CGFloat {
        maxY - y
    }
}


#Preview {
    GraphView2()
}
