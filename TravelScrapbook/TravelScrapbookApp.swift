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
    
//    @StateObject var vm = HolidayViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(HolidayViewModel())
                .environmentObject(MapViewModel())
        }
    }
    
    init() {
        FirebaseApp.configure()
    }
    
}
