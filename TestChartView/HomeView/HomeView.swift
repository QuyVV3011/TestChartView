import SwiftUI

public typealias VoidBlock = () -> Void
struct HomeView: View {
    
    @State var selectedIndex: Int = 0
    @State var selectedHome: Int = 0
    @State var showDetails: Bool = false
    var body: some View {
        ZStack {
            Color(hex: "F2F6FF")
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                    .frame(height: 47)
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
                .frame(height: 56)
                .padding(.horizontal, 20)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ReadyView()
                        
                        HomeHeartView(selectedIndex: $selectedIndex)
                            .frame(height: 407)
                            .padding(.top, 20)
                        
                        HomeLastMeasuredView(showDetail: {
                            showDetails = true
                        }).padding(.top, 16)
                        
                        HomeBloodPressureView()
                            .padding(.top, 16)
                        
                        HomeBloodOxygenView()
                            .padding(.top, 16)
                        
                        HomeHRVView()
                            .padding(.top, 16)
                        
                        HomeProgressView()
                            .padding(.top, 16)
                        
                        HomeBMIView()
                            .padding(.top, 16)
                        
                        Spacer()
                            .frame(height: 110)
                    }
                }
                
                Spacer()
                
            }
            .sheet(isPresented: $showDetails) {
                DetailtView(showDetail: $showDetails)
                    .presentationDragIndicator(.visible)
            }
            
            HomeTabbarView(selectedHome: $selectedHome)
            
        }
    }
}
#Preview {
    HomeView()
}

