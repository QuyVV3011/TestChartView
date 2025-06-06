import SwiftUI

struct StressHeartRateResultView: View {
    @Binding var valueStress: CGFloat
    @State var isExpandedStress: Bool = false
    @State var valueListLevel: [Double] = [30, 57, 93, 148]
    @State var valueListColor: [String] = ["72D59E", "FFD77A", "F7586F"]
    @State var valueListString: [String] = ["Low", "Normal", "Good"]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(.icStress)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                Text("Stress")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(hex: "152238"))
                Spacer()
            }
            .padding(.leading, 12)
            
            Spacer()
                .frame(height: 16)
            
            Text("Index of stress")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(
                    Color(hex: "6B7280")
                )
                .padding(.leading, 12)
            HStack(spacing: 0) {
                Text("95")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(
                        Color(hex: "152238")
                    )
                Text("%")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(
                        Color(hex: "152238")
                    )
            }
            .padding(.leading, 12)
            
            GraphView3()
            
            HStack {
                Text("Compared to the norm")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(
                        Color(hex: "28303F")
                    )
                Image(.icCompared)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
            }
            .padding(.top, 24)
            .padding(.leading, 12)
            
            CustomSliderView(valueCurrent: $valueStress,valueListLevel: valueListLevel, valueListColor: valueListColor, valueListString: valueListString)
            
            Spacer()
                .frame(height: 35)
            
            Text("Low stress brings numerous benefits to both your body and mind, helping you feel relaxed, reducing anxiety, and improving sleep quality. It enhances your focus, decision-making skills, and memory. Physically, low stress reduces muscle tension, stabilizes blood pressure, supports heart health, and boosts your immune system. As a result, you'll feel healthier,more energetic, and enjoy a better quality of life.")
                .font(.system(size: 14,weight: .regular))
                .foregroundStyle(
                    Color(hex: "28303F")
                )
                .lineLimit(isExpandedStress ? nil : 4)
                .multilineTextAlignment(.leading)
                .padding(.all, 12)
                .background(
                    Color(hex: "F0F4FF")
                )
                .clipShape(
                    RoundedRectangle(cornerRadius: 20)
                )
                .padding(.horizontal, 12)
                .overlay {
                    if !isExpandedStress {
                        VStack {
                            Spacer()
                            ZStack {
                                Image(.bgBottomStress)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 59)
                                Rectangle()
                                    .fill(Color.clear)
                                    .overlay {
                                        VStack {
                                            Spacer()
                                            Image(.icExpand)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 20, height: 20)
                                        }
                                    }.frame(width: 34, height: 34).onTapGesture {
                                        isExpandedStress = true
                                    }
                            }
                            
                        }
                    }
                }
            
            
        }
        .padding(.vertical,12)
        .background(
            Color(hex: "FFFFFF")
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
    }
}

