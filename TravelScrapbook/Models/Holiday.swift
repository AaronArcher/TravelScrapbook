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
    var title: String
    var isWishlist: Bool
    var visitedWith: String?
    @ServerTimestamp var date: Date?
    var location: Location
    var thumbnailImage: String?
}

struct Location: Identifiable, Codable {
    var id = UUID().uuidString
    let city: String
    let country: String
    let latitude: Double
    let longitude: Double

}

