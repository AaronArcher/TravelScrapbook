//
//  MapViewModel.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 25/07/2022.
//

import Foundation
import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 45, longitude: 15), span: MKCoordinateSpan(latitudeDelta: 70, longitudeDelta: 70))
    
}
