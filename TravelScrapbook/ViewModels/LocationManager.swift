//
//  LocationManager.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 13/06/2022.
//

import Foundation
import CoreLocation

class LocationManager {
    static let shared = LocationManager()
        
    public func findLocations(with query: String, completion: @escaping (([Location]) -> Void)) {
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(query) { places, error in
            guard let places = places, error == nil else {
                completion([])
                return
            }
        
            let models: [Location] = places.compactMap { place in
                var city = ""
                var country = ""
//                var latitude: Double = 0
//                var longitude: Double = 0
                
                
                
                if let locationName = place.name {
                    city += locationName
                }
                
                if let locationCountry = place.country {
                    country += locationCountry
                }
                
                if city == country {
                    city = ""
                }
                
//                if let locationLat = place.location?.coordinate.latitude {
//                    latitude = locationLat
//                }
//                
//                if let locationLong = place.location?.coordinate.longitude {
//                    longitude = locationLong
//                }
                
//                let result = Location(city: city, country: country, coordinates: place.location?.coordinate)
                let result = Location(city: city, country: country, latitude: place.location?.coordinate.latitude ?? 0, longitude: place.location?.coordinate.longitude ?? 0)

                return result
            }
            completion(models)
            
        }
        
    }
}
