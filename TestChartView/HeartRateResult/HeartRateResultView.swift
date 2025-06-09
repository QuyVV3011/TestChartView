import SwiftUI

struct HeartRateResultView: View {
    
    @State var valueStress: CGFloat = 60
    @State var valueHRV: CGFloat = 60
    @State var valueSDNN: CGFloat = 120
    @State var isExpandedStress: Bool = false
    
    var body: some View {
        ZStack {
            Color(hex: "F2F6FF")
            VStack {
                Spacer().frame(height: 51)
                HStack {
                    Image(.icBackHeart)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 48)
                    
                    Spacer()
                    
                    Text("Result")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundStyle(Color(hex: "0F1827"))
                    
                    Spacer()
                    
                    Image(.icBackHeart)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 48).opacity(0)
                }
                ScrollView(.vertical,showsIndicators: false) {
                    showResultHeart
                    
                    StressHeartRateResultView(valueStress: $valueStress)
                        .padding(.top, 12)
                    
                    HRVHeartRateResultView(valueHRV: $valueHRV)
                        .padding(.top, 20)
                    
                    SDNNHeartRateResultView(valueSDNN: $valueSDNN)
                        .padding(.top, 20)
                }
                
                
            }
            
            .padding(.horizontal, 20)
        }
        .ignoresSafeArea()
    }
}
#Preview {
    HeartRateResultView()
}

extension HeartRateResultView {
    var showResultHeart: some View {
        VStack {
            HStack {
                Circle()
                    .fill(Color.white)
                    .frame(height: 42)
                    .overlay {
                    Image(.icHeartRate)
                        .resizable()
                        .scaledToFit()
                        .background(Color.white)
                        .frame(width: 24, height: 24)
                }
                
                Text("Your heart")
                    .font(.system(size: 16))
                    .foregroundStyle(Color.white)
                
                Spacer()
                
                Text("Jun, 20 2024, 10:30")
                    .font(.system(size: 16))
                    .foregroundStyle(Color.white)
            }
            HStack {
                HStack {
                    VStack {
                        Text("PULSE")
                            .font(.system(size: 14, weight: .bold, design: .default))
                            .foregroundStyle(Color(hex: "FFFFFF"))
                        HStack {
                            Text("80")
                                .font(.system(size: 28, weight: .bold, design: .default))
                                .foregroundStyle(Color(hex: "FFFFFF"))
                            Text("bpm")
                                .font(.system(size: 12, weight: .bold, design: .default))
                                .foregroundStyle(Color(hex: "FFFFFF"))
                        }
                    }
                    
                    Spacer()
                        .frame(width: 24)
                    
                    VStack {
                        Text("PULSE")
                            .font(.system(size: 14, weight: .bold, design: .default))
                            .foregroundStyle(Color(hex: "FFFFFF"))
                        HStack {
                            Text("120")
                                .font(.system(size: 28, weight: .bold, design: .default))
                                .foregroundStyle(Color(hex: "FFFFFF"))
                            Text("ms")
                                .font(.system(size: 12, weight: .bold, design: .default))
                                .foregroundStyle(Color(hex: "FFFFFF"))
                        }
                    }
                    
                    
                }
                .padding(.horizontal,16.5)
                .frame(height: 81)
                .background(
                    Color(hex: "FFFFFF")
                    .opacity(0.14)
                )
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
                
                ZStack {
                    Circle()
                        .trim(from: 0.0, to: 0.9)
                        .stroke(Color.white, lineWidth: 5)
                        .rotationEffect(.degrees(107))
                        .frame(width: 98)
                    
                    Circle()
                        .fill(Color.white.opacity(0.5))
                        .frame(width: 98, height: 72)
                    
                    Circle()
                        .fill(Color.white)
                        .frame(width: 98, height: 62)
                        .padding(.all,10)
                    
                    VStack {
                        Text("Score")
                            .font(.system(size: 11, weight: .regular))
                            .foregroundColor(Color(hex: "28303F"))
                        HStack(spacing: 0) {
                            Text("\(Int(90))")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color(hex: "28303F"))
                            Text("/\(Int(100))")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(Color(hex: "28303F"))
                                .offset(y: 2)
                        }
                    }
                }
                .frame(width: 98, height: 80)
            }
            
            Spacer()
                .frame(height: 20)
            
            Text("Your heart rate is normal. Keep up the good work! If you feel any changes or discomfort, consider monitoring your condition and consulting a healthcare professional if needed.")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(Color(hex: "FFFFFF"))
                .multilineTextAlignment(.leading)
            
        }
        .padding(.horizontal, 20)
        .frame(width: UIScreen.screenWidth - 40, height: 267)
        .background(Color(hex: "30C7A3"))
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
        
    }
    
    
}
