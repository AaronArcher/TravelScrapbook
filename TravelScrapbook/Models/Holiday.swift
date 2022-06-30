//
//  Holiday.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 18/06/2022.
//

import Foundation
import CoreLocation
import UIKit

struct Holiday: Identifiable {
    let id = UUID()
    var title: String
    var date: Date
    var location: Location
    var mainImage: UIImage?
    var allImages: [UIImage] = []
}

struct Location: Identifiable {
    let id = UUID()
    let city: String
    let country: String
    let coordinates: CLLocationCoordinate2D?

}
