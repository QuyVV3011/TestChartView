//
//  ContentView.swift
//  TestChartView
//
//  Created by admin on 29/5/25.
//

import SwiftUI
import FirebaseRemoteConfig

struct ContentView: View {
    var remoteConfig: RemoteConfig
    @State var colorBottomGraph: String = "#6B7280"
    
    init(){
        remoteConfig = RemoteConfig.remoteConfig()
        let setting = RemoteConfigSettings()
        setting.minimumFetchInterval = 0
        remoteConfig.configSettings = setting
    }
    
    var body: some View {
        VStack {
            GraphView()
            Spacer()
                .frame(height: 30)
            GraphView2()
            Spacer()
                .frame(height: 30)
            GraphView3()
            Spacer()
                .frame(height: 30)
            GraphView4()
        }.onAppear {
            remoteConfig.setDefaults(["color_bottom_graph" : NSString(string: "#FFFFFF")])
            fetchRemoteConfig()
        }
    }
    
    func fetchRemoteConfig() {
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        //            let remoteConfig = RemoteConfig.remoteConfig()
        //            remoteConfig.fetchAndActivate { status, error in
        //                if let error = error {
        //                    print("❌ Remote Config error: \(error.localizedDescription)")
        //                } else {
        //                    let color = remoteConfig["color_bottom_graph"].stringValue ?? "N/A"
        //                    print("✅ Remote Config value: \(color)")
        //                }
        //            }
        //        }
        remoteConfig.configSettings.fetchTimeout = 120
        remoteConfig.fetchAndActivate() { status, error in
            switch status {
            case .successFetchedFromRemote:
                print("✅ Fetched & activated from remote")
            case .successUsingPreFetchedData:
                print("ℹ️ Using pre-fetched data")
            case .error:
                print("❌ Error fetching remote config: \(error?.localizedDescription ?? "Unknown")")
            @unknown default:
                break
            }
            if status == .successFetchedFromRemote || status == .successUsingPreFetchedData {
                DispatchQueue.main.async {
                    self.colorBottomGraph = self.remoteConfig.configValue(forKey: "color_bottom_graph").stringValue
                    print("colorBottom: \(colorBottomGraph)")
                }
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
