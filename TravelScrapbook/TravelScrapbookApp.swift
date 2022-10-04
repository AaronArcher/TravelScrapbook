//
//  TravelScrapbookApp.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 13/06/2022.
//

import SwiftUI
import Firebase

@main
struct TravelScrapbookApp: App {
    
    @StateObject var holidayVM = HolidayViewModel()
    @StateObject var mapVM = MapViewModel()
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(holidayVM)
                .environmentObject(mapVM)
                .preferredColorScheme(isDarkMode ? .dark : .light)

        }
    }
    
    init() {
        FirebaseApp.configure()
    }
    
}
