//
//  Holiday.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 18/06/2022.
//

import Foundation
import CoreLocation
import UIKit
import FirebaseFirestoreSwift


struct Holiday: Identifiable {
    var id = UUID()
    var createdBy: String
    var title: String
    var date: Date
    var location: Location
    var mainImage: UIImage?
    var allImages: [UIImage] = []
}

struct Location: Identifiable {
    var id = UUID()
    let city: String
    let country: String
//    let coordinates: CLLocationCoordinate2D
    let latitude: Double?
    let longitude: Double?

}
