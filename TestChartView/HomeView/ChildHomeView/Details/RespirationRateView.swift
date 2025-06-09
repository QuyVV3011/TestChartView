import SwiftUI


struct RespirationRateView: View {
    
    @State var currentTime: String = ""
    @State var pulseValue: Int = 75
    @State var heartScoreValue: Int = 75
    @State var numberMeasurementToday: Int = 3
    @State var days: [[DayItem]] = []
    
    let calendar = Calendar.current
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Today at \(currentTime)")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color(hex: "#28303F"))
                    Spacer()
                }.padding(.horizontal, 12)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Index")
                        .font(.system(size: 12, weight: .regular))
                    HStack(spacing: 0) {
                        Text("28")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(Color(hex: "#28303F"))
                        Text("%")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(Color(hex: "#28303F"))
                        
                        HStack(spacing: 4) {
                            Image(systemName: "arrow.down")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                            Text("+11")
                                .font(.system(size: 12, weight: .semibold))
                        }
                        .foregroundColor(Color(hex: "72D59E"))
                        .font(.system(size: 12, weight: .medium))
                        .padding(.leading, 6)
                        .background(Color.white)
                        .cornerRadius(12)
                        
                        Text("Normal")
                            .font(.system(size: 11, weight: .regular))
                            .frame(width: 58, height: 20)
                            .background(Color(hex: "#72D59E").opacity(0.2))
                            .clipShape(
                                RoundedRectangle(cornerRadius: 12)
                            ).padding(.leading, 8)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.top, 12)
                
                GraphView3()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(days.indices,id: \.self) { index in
                            ForEach(days[index].indices, id: \.self) { index2 in
                                RoundedRectangle(cornerRadius: 100).strokeBorder(Color(hex: "F36084"), lineWidth: 1).overlay {
                                    VStack {
                                        Circle()
                                            .fill(Color(hex: "F36084"))
                                            .frame(height: 34).overlay {
                                                Text("\(days[index][index2].dayText)")
                                                    .font(.system(size: 12, weight: .regular))
                                                    .foregroundStyle(Color(hex: "FFFFFF"))
                                            }.padding(.top, 3)
                                        Spacer()
                                        Text("\(days[index][index2].weekdayText)")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundStyle(Color(hex: "6B7280")).padding(.bottom, 12)
                                    }
                                }
                                .overlay(content: {
                                    VStack {
                                        HStack {
                                            Spacer()
                                            Image(.icSelected)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 12, height: 12)
                                        }
                                        
                                        Spacer()
                                    }
                                    
                                })
                                .frame(width: 40, height: 77)
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.top, 16)
                }
                
                Spacer().frame(height: 12)
                
            }.onAppear {
                updateTime()
                days = generateCalendar(for: Calendar.current.component(.month, from: Date()), year: Calendar.current.component(.year, from: Date()))
                print(days)
            }
        }
        
    }
    
    private func updateTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        currentTime = formatter.string(from: Date())
    }
    
    func numberOfDays(in month: Int, year: Int) -> Int? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        
        let calendar = Calendar.current
        
        // Tạo một ngày đầu tháng
        if let date = calendar.date(from: dateComponents),
           let range = calendar.range(of: .day, in: .month, for: date) {
            return range.count
        }
        
        return nil
    }
    
    func generateDaysInMonth(month: Int, year: Int) -> [Date] {
        var dates: [Date] = []
        let calendar = Calendar.current
        var components = DateComponents(year: year, month: month, day: 1)
        
        if let startOfMonth = calendar.date(from: components),
           let range = calendar.range(of: .day, in: .month, for: startOfMonth) {
            for day in range {
                components.day = day
                if let date = calendar.date(from: components) {
                    dates.append(date)
                }
            }
        }
        
        return dates
    }
    
    func generateCalendar(for month: Int, year: Int) -> [[DayItem]] {
        var result: [[DayItem]] = []
        let calendar = Calendar.current
        var components = DateComponents(year: year, month: month)
        components.day = 1
        
        guard let firstDayOfMonth = calendar.date(from: components),
              let range = calendar.range(of: .day, in: .month, for: firstDayOfMonth) else {
            return result
        }
        
        let weekdaySymbols = calendar.shortWeekdaySymbols // ["Sun", "Mon", ..., "Sat"]
        
        var days: [DayItem] = []
        
        
        for day in range {
            components.day = day
            if let date = calendar.date(from: components) {
                let weekday = calendar.component(.weekday, from: date)
                let weekdayText = String(weekdaySymbols[weekday - 1].prefix(2)) // "Mo", "Tu", ...
                days.append(DayItem(date: date, dayText: "\(day)", weekdayText: weekdayText))
                
            }
        }
        
        
        for chunk in stride(from: 0, to: days.count, by: 7) {
            let week = Array(days[chunk..<min(chunk+7, days.count)])
            result.append(week)
        }
        
        return result
    }
}


#Preview {
    RespirationRateView()
}

