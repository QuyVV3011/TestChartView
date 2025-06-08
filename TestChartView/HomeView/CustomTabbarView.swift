import SwiftUI
struct CustomTabbarView: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        
        let center = width / 2
        let bumpWidth: CGFloat = 90
        let bumpHeight: CGFloat = 20
        
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: 0, y: 0))
        
        // Vẽ đường cong "nhô lên" mềm
        path.addCurve(
            to: CGPoint(x: center, y: -bumpHeight),
            control1: CGPoint(x: center - bumpWidth / 2, y: 0),
            control2: CGPoint(x: center - bumpWidth / 2, y: -bumpHeight)
        )
        
        path.addCurve(
            to: CGPoint(x: width, y: 0),
            control1: CGPoint(x: center + bumpWidth / 2, y: -bumpHeight),
            control2: CGPoint(x: center + bumpWidth / 2, y: 0)
        )
        
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        return path
    }
}


