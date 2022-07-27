//
//  Holiday.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 18/06/2022.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore


struct Holiday: Identifiable, Codable {
    @DocumentID var id: String?
    var createdBy: String?
    var title: String
    @ServerTimestamp var date: Date?
    var location: Location
    var mainImage: String?
    var allImages: [String] = []
}

struct Location: Identifiable, Codable {
    var id = UUID().uuidString
    let city: String
    let country: String
//    let coordinates: CLLocationCoordinate2D
    let latitude: Double
    let longitude: Double

}

