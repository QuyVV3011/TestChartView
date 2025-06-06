import SwiftUI

struct HomeHeartAgeView: View {
    
    @State var currentTime: String = ""
    @State var yourAgeValue: Int = 41
    @State var biologicalAgeValue: Int = 35
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                HStack {
                    Text("Today at \(currentTime)")
                    Spacer()
                }.padding(.horizontal, 12)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Your Age")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(Color(hex: "6B7280"))
                        HStack(spacing: 0) {
                            Text("\(yourAgeValue)")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundStyle(Color(hex: "28303F"))
                        }
                    }
                    Spacer()
                        .frame(width: 16)
                    
                    Rectangle()
                        .fill(Color(hex: "E1E1E1"))
                        .frame(width: 1,height: 18)
                    
                    Spacer()
                        .frame(width: 16)
                    
                    VStack(alignment: .leading) {
                        Text("Biological Age")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(Color(hex: "6B7280"))
                        HStack(spacing: 0) {
                            Text("\(biologicalAgeValue)")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundStyle(Color(hex: "28303F"))
                        }
                    }
                }
                .padding(.horizontal, 12)
                
                GraphView()
                
                HStack {
                    Text("Your Age")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color(hex: "243044"))
                        .frame(width: 185, height: 36)
                        .background(Color(hex: "EBEFF8"))
                        .clipShape(
                            RoundedRectangle(cornerRadius: 12)
                        )
                    
                    HStack {
                        Circle()
                            .fill(Color(hex: "F36084"))
                            .frame(height: 10)
                        Text("Biological Age")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(Color(hex: "243044"))
                    }
                    .frame(width: 185, height: 36)
                    .background(Color(hex: "EBEFF8"))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                }.padding(.horizontal, 12)
                ZStack {
                    HStack {
                        Image(.icStar)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text("Get more insight")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color(hex: "243044"))
                        
                    }
                    .frame(width: geo.size.width - 24, height: 48)
                    .background(Color(hex: "EBEFF8"))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
              
                    HStack {
                        Spacer()
                        Circle().fill(LinearGradient(colors: [Color(hex: "F07B8C"), Color(hex: "EA475E")], startPoint: .top, endPoint: .bottom)).frame(height: 40).padding(.trailing, 16)
                    }
                }      .padding(.horizontal, 12)
               
            }.onAppear {
                updateTime()
            }
        }
    }
    
    private func updateTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        currentTime = formatter.string(from: Date())
    }
}
#Preview {
    HomeHeartAgeView()
}
