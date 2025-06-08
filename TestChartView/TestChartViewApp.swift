//
//  TestChartViewApp.swift
//  TestChartView
//
//  Created by admin on 29/5/25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        guard let plistPath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
              let options = FirebaseOptions(contentsOfFile: plistPath) else {
            print("❌ Failed to load Firebase options from plist")
            return false
        } 
        FirebaseApp.configure(options: options)
        return true
    }
    
    
    
    static let googleConfig: String = {
        guard let name = infoDictionary["GOOGLE_PLIST_FILE_NAME"] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        return name
    }()
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
}

@main
struct TestChartViewApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var isFirebaseReady = false

    var body: some Scene {
        WindowGroup {
//            if isFirebaseReady {
//                ContentView()
//            } else {
//                Color.clear
//                    .onAppear {
//                        DispatchQueue.main.async {
//                            // Delay 1 frame to ensure AppDelegate ran
//                            isFirebaseReady = FirebaseApp.app() != nil
//                        }
//                    }
//            }
//            HeartRateResultView()
            HomeView().ignoresSafeArea()
        }
    }
}

