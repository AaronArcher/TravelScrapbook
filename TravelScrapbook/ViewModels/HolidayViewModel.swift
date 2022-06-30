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
    
    @Published var holidayName = ""
    @Published var holidayCity = ""
    @Published var holidayCountry = ""
    @Published var holidayDate = Date()
    
    
    func addHoliday(title: String, city: String, country: String, date: Date, coordinates: CLLocationCoordinate2D, mainImage: UIImage) {
        
        DispatchQueue.main.async {
            self.holidays.append(
                Holiday(
                    title: title,
                    date: date,
                    location: Location(
                        city: city,
                        country: country,
                        coordinates: coordinates),
                    mainImage: mainImage
                )
            )
        }

    }
    
}
