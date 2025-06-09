import SwiftUI

struct AutoScrollRecommend: View {
    @State var recomendList: [String] = [
        "Maintain a habit of gentle daily exercise",
        "Ensure consistent sleep patterns (7-8 hours per night)",
        "Practice stress-reducing activities such as"
    ]
    
    var body: some View {
        
        VStack(alignment: .leading,spacing: 0) {
            Text(" Recomendation:").font(.system(size: 14, weight: .semibold)).foregroundStyle(Color(hex: "28303F"))
            
            ForEach(recomendList.indices, id: \.self) { index in
                HStack(alignment: .top, spacing: 6) {
                    
                    Circle()
                        .fill(Color(hex: "28303F"))
                        .frame(width: 6, height: 6)
                        .padding(.top, 5)
                    
                    Text("\(recomendList[index])")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(Color(hex: "28303F"))
                }
            }
            .padding(.top, 12)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(Color(hex: "FFFFFF"))
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
        .padding(.horizontal, 20)
        
    }
}

#Preview {
    AutoScrollRecommend().preferredColorScheme(.dark)
}
