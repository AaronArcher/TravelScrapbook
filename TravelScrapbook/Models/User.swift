//
//  User.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 26/07/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    
    @DocumentID var id: String?
    var firstname: String
    var lastname: String
    var email: String
    var shareKey: String
    
}
