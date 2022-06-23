//
//  TravelScrapbookApp.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 13/06/2022.
//

import SwiftUI

@main
struct TravelScrapbookApp: App {
    
    @StateObject var vm = HolidayViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView2()
                .environmentObject(vm)
        }
    }
}
