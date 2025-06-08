import SwiftUI


struct HomeHRVView: View {
    
    @State var currentTime: String = ""
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0) {
            Spacer()
                .frame(height: 12)
            HStack(spacing: 8) {
                Image(.icHrv)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                
                Text("HRV")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(Color(hex: "152238"))
                
                Spacer()
                
                Text("History")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(Color(hex: "28303F"))
                    .frame(width: 65, height: 24)
                    .background(Color(hex: "F2F6FF"))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 8)
                    )
            }
            .padding(.horizontal, 12)
            
            HStack {
                Text("Today at \(currentTime)")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(Color(hex: "28303F"))
                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.top, 16)
            
            Text("Index")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(
                    Color(hex: "6B7280")
                )
                .padding(.leading, 12).padding(.top, 8)
            HStack(spacing: 0) {
                Text("95")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(
                        Color(hex: "28303F")
                    )
                Text("ms")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(
                        Color(hex: "152238")
                    )
            }
            .padding(.leading, 12)
            
            GraphView3()
                .padding(.top, 5)
            
            Spacer()
                .frame(height: 12)
        }
        .background(Color(hex: "FFFFFF"))
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
        .padding(.horizontal, 20)
        .onAppear {
            updateTime()
        }
    }
    private func updateTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        currentTime = formatter.string(from: Date())
    }
}
#Preview {
    HomeHRVView()
}



