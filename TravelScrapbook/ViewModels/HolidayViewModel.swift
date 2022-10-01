//
//  HolidayViewModel.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 18/06/2022.
//

import Foundation
import CoreLocation
import UIKit

enum SelectedCategory: String, CaseIterable {
    case all = "All Locations"
    case visited = "Visited Locations"
    case wishlist = "Wishlist Locations"
}

class HolidayViewModel: ObservableObject {
    
    @Published var selectedCategory: SelectedCategory = .all
        
    @Published var allHolidays: [Holiday] = []
    @Published var visited: [Holiday] = []
    @Published var wishlist: [Holiday] = []
        
    @Published var allHolidayImage: [String] = []
    
    var databaseService = DatabaseService()
    
    
    func getholidays() {
        
        
        databaseService.getVisited { holidays in
            self.allHolidays = holidays
            self.visited = holidays
            
        }
        databaseService.getWishlist { holidays in

            self.wishlist = holidays
            
        }
        
    }
    
    func holidayCleanup() {
        databaseService.detachHolidayListner()
    }
    

    
}
