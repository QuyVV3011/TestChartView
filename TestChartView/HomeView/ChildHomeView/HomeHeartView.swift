import SwiftUI
import SwiftUIPager

struct HomeHeartView: View {
    @Binding var selectedIndex: Int
    
    @State private var page: Page = .first()
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 12)
            sliderStyle
                .padding(.horizontal, 12)
            
            Pager(page: page,
                  data: [0, 1],
                  id: \.self) { index in
                switch index {
                case 0:
                    HomeHeartRateView()
                        .padding(.top, 4)
                case 1:
                    HomeHeartAgeView()
                        .padding(.top, 4)
                default:
                    EmptyView()
                }
            }
            .allowsDragging(false)
            .animation(.easeInOut, value: page.index)
            
        }
        .background(Color(hex: "FFFFFF"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 20)
        .frame(height: 416)
    }
}

extension HomeHeartView {
    var sliderStyle: some View {
        GeometryReader { geometry in
            let tabWidth = geometry.size.width / CGFloat(2)
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(hex: "F2F6FF"))
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .frame(width: tabWidth - 6, height: 40)
                    .offset(x: CGFloat(selectedIndex) * tabWidth + 3)
                    .shadow(color: .black.opacity(0.05), radius: 1, x: 0, y: 1)
                    .animation(.easeInOut(duration: 0.3), value: selectedIndex)
                
                HStack(spacing: 0) {
                    Button(action: {
                        selectedIndex = 0
                        page.update(.new(index: 0))
                    }) {
                        HStack(spacing: 6) {
                            Image(selectedIndex == 0 ? .icHeart : .icHeartNo)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text("Heart Rate")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 36)
                        .foregroundColor(selectedIndex == 0 ? .black : .gray)
                    }
                    
                    Button(action: {
                        selectedIndex = 1
                        page.update(.new(index: 1))
                    }) {
                        HStack(spacing: 6) {
                            Image(selectedIndex == 1 ? .icHeartAge : .icHeartAgeNo)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text("Heart Age")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 36)
                        .foregroundColor(selectedIndex == 1 ? .black : .gray)
                    }
                }
            }
        }
        .frame(height: 44)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
