//
//  Holiday.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 18/06/2022.
//

import Foundation
import CoreLocation

struct Holiday: Identifiable {
    let id = UUID()
    let name: String
    let date: Date
    let location: Location
}

struct Location: Identifiable {
    let id = UUID()
    let city: String
    let country: String
    let coordinates: CLLocationCoordinate2D?
//    let latitude: Double
//    let Longitude: Double
}