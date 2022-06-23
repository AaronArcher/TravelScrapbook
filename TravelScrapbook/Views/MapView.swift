//
//  MapView.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 23/06/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @EnvironmentObject var holidayvm: HolidayViewModel
    
    @Binding var region: MKCoordinateRegion
    
    var body: some View {

        Map(coordinateRegion: $region, annotationItems: holidayvm.holidays) { holiday in
            MapAnnotation(coordinate: holiday.location.coordinates ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)) {
                MapAnnotationView(holiday: holiday)
            }
        }

    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        let vm = HolidayViewModel()
//        MapView()
//            .environmentObject(vm)
//    }
//}
