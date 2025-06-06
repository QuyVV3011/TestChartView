import SwiftUI

struct ReadyView: View {
    var body: some View {
        HStack {
            Image(.icReady)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding(.leading, 12)
           
            Text("Get your full heart\nhealth report").font(.system(size: 16, weight: .medium)).foregroundStyle(Color(hex: "FFFFFF")).padding(.leading, 12)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Ready").font(.system(size: 16, weight: .semibold)).foregroundStyle(Color(hex: "FFFFFF"))
                    .frame(width: 89, height: 42)
                    .background(Color(hex: "030D5B"))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding(.trailing, 12)

        }
        .frame(width: UIScreen.screenWidth - 40, height: 61)
        .background(
            LinearGradient(colors: [Color(hex: "6475F0"), Color(hex: "70ABFF")], startPoint: .top, endPoint: .bottom)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 20 )
        )
        .padding(.horizontal, 20)
    }
}
