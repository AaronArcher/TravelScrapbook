//
//  HolidayViewModel.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 18/06/2022.
//

import Foundation
import CoreLocation
import UIKit

class HolidayViewModel: ObservableObject {
    
    @Published var holidays: [Holiday] = []
        
    @Published var allHolidayImage: [String] = []
    
    var databaseService = DatabaseService()
    
//    @Published var title = ""
//    @Published var city = ""
//    @Published var country = ""
//    @Published var date = Date()
    
//    init() {
//        // get all holidays when instance is created
//        getholidays()
//    }
    
    func getholidays() {
        
        databaseService.getAllHolidays { holidays in
            self.holidays = holidays
//            dump(holidays)
        }
        
    }
    
    func holidayCleanup() {
        databaseService.detachHolidayListner()
    }
    
//    func addHoliday(title: String, city: String, country: String, date: Date, latitude: Double, longitude: Double, mainImage: UIImage) {
//        
//        DispatchQueue.main.async {
//            self.holidays.append(
//                Holiday(
//                    createdBy: AuthViewModel.getLoggedInUserID(),
//                    title: title,
//                    date: date,
//                    location: Location(
//                        city: city,
//                        country: country,
//                        latitude: latitude,
//                        longitude: longitude),
//                        mainImage: mainImage
//                )
//            )
//        }
//
//    }
    
//    func newHoliday(holiday: Holiday) {
//        
//        databaseService.createHoliday(holiday: holiday) { docID in
//            
//            
//            
//        }
//        
//    }
    
}
