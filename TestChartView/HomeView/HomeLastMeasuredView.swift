import SwiftUI

struct HomeLastMeasuredView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Last measured").font(.system(size: 16, weight: .medium)).foregroundStyle(Color(hex: "28303F")).padding(.horizontal, 20)
                Spacer()
            }
            
            HStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(hex: "FFFFFF"))
                    .frame(width: 180, height: 158)
                    .overlay {
                        VStack(spacing: 0) {
                            HStack {
                                Image(.icStress)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                Text("Stress")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundStyle(Color(hex: "152238"))
                                Spacer()
                                
                                Image(.icArrowRight)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                            }
                            .padding(.top, 12)
                            .padding(.horizontal, 12)
                            Spacer()
                            
                            CircularProgressView(progress: 0.2, label: "Good", valueText: 128, valueType: "ms", color: Color(hex: "30C7A3"))
                        }
                    }
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(hex: "FFFFFF"))
                    .frame(width: 180, height: 158)
                    .overlay {
                        VStack(spacing: 0) {
                            HStack {
                                Image(.icEnergy)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                Text("Energy")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundStyle(Color(hex: "152238"))
                                
                                Spacer()
                                
                                Image(.icArrowRight)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                            }
                            .padding(.top, 12)
                            .padding(.horizontal, 12)
                            
                            Spacer()
                            
                            CircularProgressView(progress: 0.4, label: "High", valueText: 128, valueType: "ms", color: Color(hex: "F7586F"))
                        }
                    }
            }
        }.padding(.horizontal, 20)
    }
}
#Preview {
    HomeLastMeasuredView()
}

