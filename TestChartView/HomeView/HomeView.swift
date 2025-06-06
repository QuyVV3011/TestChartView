import SwiftUI

struct HomeView: View {
    
    @State var selectedIndex: Int = 0
    
    var body: some View {
        ZStack {
            Color(hex: "F2F6FF").ignoresSafeArea()
            VStack {
                HStack {
                    Text("Home")
                        .font(.system(size: 28,weight: .bold))
                        .foregroundStyle(Color(hex: "0F1827"))
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(.icSetting)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 24)
                    }
                }
                .padding(.horizontal, 20)
                
                ReadyView()
                
                HomeHeartView(selectedIndex: $selectedIndex).frame(height: 407)
                
            }
        }
    }
}
#Preview {
    HomeView()
}


