import SwiftUI

struct HomeBloodPressureView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 12)
            HStack(spacing: 8) {
                Image(.icBloodPressure)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                
                Text("Blood Pressure")
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
            
            GraphView2()
                .padding(.top, 28)
            
            HStack(spacing: 8) {
                VStack {
                    HStack {
                        Circle()
                            .fill(Color(hex: "FD4560"))
                            .frame(height: 10)
                            .padding(.leading, 20)
                        Text("Systolic")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(Color(hex: "243044"))
                        Spacer()
                    }
                    
                    HStack {
                        Text("--")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(Color(hex: "243044"))
                            .padding(.leading, 20)
                        Text("mmHg")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(Color(hex: "353F50"))
                        Spacer()
                    }
                }
                .frame(width: 158, height: 68)
                .background(Color(hex: "EBEFF8"))
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
                
                Spacer()
                
                VStack {
                    HStack {
                        Circle()
                            .fill(Color(hex: "3685F5"))
                            .frame(height: 10)
                            .padding(.leading, 20)
                        Text("Diastolic")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(Color(hex: "243044"))
                        Spacer()
                    }
                    
                    HStack {
                        Text("--")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(Color(hex: "3685F5"))
                            .padding(.leading, 20)
                        Text("mmHg")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(Color(hex: "353F50"))
                        Spacer()
                    }
                }
                .frame(width: 158, height: 68)
                .background(Color(hex: "EBEFF8"))
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
                
            }.padding(.horizontal, 20)
            
            Spacer()
                .frame(height: 12)
        }
        .background(Color(hex: "FFFFFF"))
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
        .padding(.horizontal, 20)
    }
}
#Preview {
    HomeBloodPressureView()
}
