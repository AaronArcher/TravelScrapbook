//
//  HolidayViewModel.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 18/06/2022.
//

import Foundation
import CoreLocation
import UIKit

enum selectedCategory {
    case all
    case wishlist
    case visited
}

class HolidayViewModel: ObservableObject {
    

    
    @Published var selectedCategory: selectedCategory = .all
        
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
