import SwiftUI

struct DetailRespirationRate: View {
    
    @State var currentValue: CGFloat = 59
    @State var valueListLevel: [Double] = [30, 57, 93, 148]
    @State var valueListColor: [String] = ["72D59E", "FFD77A", "F7586F"]
    @State var valueListString: [String] = ["Low", "Normal", "Good"]
    @State var titleCompared: String = "Your stress level is lower than average (good)."
    @State var titleReview: String = "Low stress brings numerous benefits to both your body and mind, helping you feel relaxed, reducing anxiety, and improving sleep quality. It enhances your focus, decision-making skills, and memory. Physically, low stress reduces muscle tension, stabilizes blood pressure, supports heart health, and boosts your immune system. As a result, you'll feel healthier, more energetic, and enjoy a better quality of life."
    
    var body: some View {
        
        ZStack {
            Color(hex: "F2F6FF").ignoresSafeArea()
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .leading) {
                        Spacer()
                            .frame(height: 20)
                        
                        HStack {
                            Button {
                               
                            } label: {
                                Text("Close")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundStyle(Color(hex: "F36084"))
                            }
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                HStack {
                                    Image(.icPlus)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                    Text("Add")
                                        .font(.system(size: 17, weight: .regular))
                                        .foregroundStyle(Color(hex: "F36084"))
                                }
                            }
                        }.padding(.horizontal, 16)
                        
                        HStack {
                            Text("Respiration Rate")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(Color(hex: "28303F"))
                            
                            Spacer()
                            
                            Image(.icCompared)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                        }
                        .padding(.horizontal, 20)
                        
                        RespirationRateView()
                            .padding(.top, 12)
                            .background(Color(hex: "FFFFFF"))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.horizontal, 20)
                            .frame(height: 324)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Compared to the norm")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(
                                        Color(hex: "28303F")
                                    )
                                Spacer()
                            }
                            .padding(.top, 24)
                            .padding(.leading, 12)
                            
                            CustomSliderView(valueCurrent: $currentValue,valueListLevel: valueListLevel, valueListColor: valueListColor, valueListString: valueListString, showIncrease: .constant(false))
                                .padding(.horizontal, 12)
                                .padding(.top, 28)
                            
                            Path { path in
                                path.move(to: CGPoint(x: 0, y: 0))
                                path.addLine(to: CGPoint(x: geometry.size.width - 62 , y: 0))
                            }
                            .stroke(Color(hex: "#D8D8D8"), style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .padding(.top, 40)
                            .padding(.horizontal, 12)
                            
                            
                            Text("\(titleCompared)")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(Color(hex: "353F50"))
                                .padding(.leading, 12)
                                .padding(.bottom, 16)
                            
                            Spacer()
                        }
                        .frame(height: 224)
                        .background(Color(hex: "FFFFFF"))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal, 20)
                        .padding(.top, 16)
                        
                        AutoScrollReviews(text: titleReview)
                        
                        AutoScrollRecommend()
                        
                        Spacer()
                            .frame(height: 100)

                    }
                }
            }
        }
    }
}
#Preview {
    DetailRespirationRate()
}



