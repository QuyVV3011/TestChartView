import SwiftUI

struct HomeProgressView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State var progressList: [ProgressModel] = [
        ProgressModel(lableText: "SDNN", statusText: "Good", valueProgess: 128, typeValue: "ms", colorProgess: Color(hex: "30C7A3")),
        ProgressModel(lableText: "RMSSD", statusText: "High", valueProgess: 231, typeValue: "ms", colorProgess: Color(hex: "D73842")),
        ProgressModel(lableText: "PNN50", statusText: "Very High", valueProgess: 78, typeValue: "%", colorProgess: Color(hex: "D73842")),
        ProgressModel(lableText: "CoV", statusText: "Good", valueProgess: 13, typeValue: "ms", colorProgess: Color(hex: "30C7A3"))
    ]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(0..<progressList.count, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(hex: "FFFFFF"))
                        .frame(width: 180, height: 158)
                        .overlay {
                            VStack(spacing: 0) {
                                HStack {
                                    
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
                                .padding(.horizontal, 14)
                                
                                Spacer()
                                
                                CircularProgressView(progress: 0.4, label: progressList[index].lableText, valueText: progressList[index].valueProgess,valueType: progressList[index].typeValue, color: progressList[index].colorProgess)
                                    .padding(.bottom, 12)
                            }
                        }
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    HomeProgressView().preferredColorScheme(.dark)
}

struct ProgressModel: Identifiable {
    let id = UUID()
    let lableText: String
    let statusText: String
    let valueProgess: Int
    let typeValue: String
    let colorProgess: Color
}


