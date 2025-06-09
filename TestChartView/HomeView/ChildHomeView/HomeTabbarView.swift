import SwiftUI

struct HomeTabbarView: View {
    @Binding var selectedHome: Int
    var body: some View {
        VStack {
            Spacer()
            CustomTabbarView().shadow(radius: 4)
                .overlay(content: {
                    HStack {
                        VStack {
                            Image(.icHome).renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(selectedHome == 0 ? Color(hex: "F36084") : Color(hex: "243044"))
                                .frame(height: 24)
                            Text("Home")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(selectedHome == 0 ? Color(hex: "F36084") : Color(hex: "243044"))
                        }
                        .frame(width: 84,height: 64)
                        .padding(.leading, 26)
                        .onTapGesture {
                            selectedHome = 0
                        }
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Circle()
                                .fill(Color(hex: "F36084"))
                                .overlay {
                                    Image(systemName: "plus")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(Color(hex: "FFFFFF"))
                                        .frame(width: 17, height: 17)
                                }
                                .frame(width: 68, height: 68)
                                .offset(y: -15)
                                .onTapGesture {
                                    
                                }
                        }
                        Spacer()
                        
                        VStack {
                            Image(.icWrite)
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(selectedHome == 1 ? Color(hex: "F36084") : Color(hex: "243044"))
                                .frame(height: 24)
                            Text("Write")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(selectedHome == 1 ? Color(hex: "F36084") : Color(hex: "243044"))
                        }
                        .frame(width: 84,height: 64)
                        .padding(.trailing, 26)
                        .onTapGesture {
                            selectedHome = 1
                        }
                    }.padding(.bottom, 25)
                })
                .foregroundStyle(Color(hex: "FFFFFF"))
                .frame(height: 90)
        }
        .ignoresSafeArea()
    }
}

