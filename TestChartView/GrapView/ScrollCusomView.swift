import SwiftUI
import UIKit

enum SmoothScrollableTrigger {
    case none
    case scroll(offset: Double)
    case pause(offset: Double)
    case refresh
    case reset
}

struct ScrollCusomView<Content: View>: UIViewRepresentable {
    
    @Binding var trigger: SmoothScrollableTrigger
    @Binding var offset: CGFloat
    var onScrollEnd : (CGFloat) -> Void = { _ in }
    let content: Content
    
    init(trigger: Binding<SmoothScrollableTrigger>,
         offset: Binding<CGFloat>,
         @ViewBuilder content: () -> Content,
         onScrollEnd: ((CGFloat) -> Void)? = nil) {
        self._trigger = trigger
        self._offset = offset
        
        self.content = content()
        if let onScrollEnd = onScrollEnd {
            self.onScrollEnd = onScrollEnd
        }
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.backgroundColor = .clear
        
        let hostingController = UIHostingController(rootView: content)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        scrollView.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostingController.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        context.coordinator.hostingController = hostingController
        return scrollView
    }
    
    func updateUIView(_ scrollView: UIScrollView, context: Context) {
        scrollView.delegate = context.coordinator // Đảm bảo delegate không bị mất
        
        
        switch trigger {
        case .none:
            return
        case .scroll(let offset):
            context.coordinator.scrollTo(scrollView: scrollView, offset: offset)
        case .pause(let offset):
            context.coordinator.pauseScroll(scrollView: scrollView, offset: offset)
        case .refresh:
            if let hostingController = context.coordinator.hostingController {
                hostingController.rootView = content
            }
        case .reset:
            if let hostingController = context.coordinator.hostingController {
                hostingController.rootView = content
            }
            context.coordinator.resetScroll(scrollView: scrollView)
       
        }
        DispatchQueue.main.async {
            trigger = .none
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: ScrollCusomView
        var hostingController: UIHostingController<Content>?
        private var animator: UIViewPropertyAnimator?
        
        init(_ parent: ScrollCusomView) {
            self.parent = parent
        }
        
        func scrollTo(scrollView: UIScrollView, offset: Double) {
            scrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: false)
        }
        
        func pauseScroll(scrollView: UIScrollView, offset: Double) {
            animator?.stopAnimation(true)
            animator = nil
            scrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: false)
        }
        
        func resetScroll(scrollView: UIScrollView) {
            animator?.stopAnimation(true)
            animator = nil
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            DispatchQueue.main.async {
                self.parent.offset = scrollView.contentOffset.x
            }
            
        }
        
        func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            //            print("begin dragging")
            
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if !decelerate {
                //                print("✅ Người dùng thả tay và `ScrollView` đã dừng!")
                                DispatchQueue.main.async {
                                    self.parent.onScrollEnd(scrollView.contentOffset.x)
                //                    self.parent.isUserticScroll = false
                                }
                
            } else {
                //                print("⚡ Người dùng thả tay nhưng `ScrollView` vẫn tiếp tục trượt (decelerate).")
                //                parent.isUserticScroll = true
            }
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            //            print("✅ `ScrollView` đã hoàn toàn dừng lại sau khi trượt!")
            DispatchQueue.main.async {
                self.parent.onScrollEnd(scrollView.contentOffset.x)
                //                self.parent.isUserticScroll = false
            }
        }
    }
}

