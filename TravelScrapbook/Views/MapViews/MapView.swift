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
    @EnvironmentObject var mapvm: MapViewModel
        
    let namespace: Namespace.ID
    
    @Binding var showMarker: Bool
    @Binding var showCancel: Bool
    
    @Binding var openSearch: Bool
    @Binding var showSearchContent: Bool
    
    @Binding var addNewHoliday: Bool
    @Binding var showAddNewHolidayContent: Bool

    
    var body: some View {
        
        ZStack {
            
            switch holidayvm.selectedCategory {
            case .all:
                Map(coordinateRegion: $mapvm.region, annotationItems: (holidayvm.wishlist + holidayvm.visited)) { holiday in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: holiday.location.latitude, longitude: holiday.location.longitude)) {
                        MapAnnotationView(holiday: holiday, span: mapvm.region.span.latitudeDelta)
                    }
                }
                    .disabled(addNewHoliday)
                
            case .visited:
                Map(coordinateRegion: $mapvm.region, annotationItems: holidayvm.visited) { holiday in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: holiday.location.latitude, longitude: holiday.location.longitude)) {
                        MapAnnotationView(holiday: holiday, span: mapvm.region.span.latitudeDelta)
                    }
                }
                    .disabled(addNewHoliday)
                
            case .wishlist:
                Map(coordinateRegion: $mapvm.region, annotationItems: holidayvm.wishlist) { holiday in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: holiday.location.latitude, longitude: holiday.location.longitude)) {
                        MapAnnotationView(holiday: holiday, span: mapvm.region.span.latitudeDelta)
                    }
                }
                    .disabled(addNewHoliday)
                
            }
            
                
            Image(systemName: "mappin")
                .resizable()
                .matchedGeometryEffect(id: "pin", in: namespace)
                .foregroundColor(Color("Green1"))
                .scaledToFit()
                .frame(width: 24, height: 24)
                .offset(y: -12)
                .scaleEffect(showMarker ? 1 : 0.001) // The "0.001 removed 'ignoring singular matrix' error in console
            
                Text("Confirm your holiday location")
                    .font(.footnote)
                    .foregroundColor(Color("PrimaryGreen"))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(
                        RoundedCornerShape(radius: 10, corners: [.bottomLeft, .bottomRight])
                            .foregroundColor(Color("ButtonBackground"))
                            .shadow(color: Color("Green2").opacity(0.15), radius: 10, x: 4, y: 4)

                    )
                    .frame(maxHeight: .infinity, alignment: .top)
                    .offset(y: showMarker ? 0 : -80)
            
            newHolidayButton
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            
        }
        
    }
    
    var newHolidayButton: some View {
        HStack(spacing: 10) {

            Spacer()


            if showCancel {
            Button {
                DispatchQueue.main.async {
                    withAnimation(.easeInOut) {
                        showMarker = false
                        showCancel = false
                    }
                }
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.red)
                    .frame(width: 20, height: 20)
            }
            .padding(15)
            .background(
                Circle()
                    .foregroundColor(Color("TextBackground"))
                    .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)

            )
            .transition(.scale)
            .scaleEffect(addNewHoliday ? 0.001 : 1)
            }


            if !addNewHoliday {
                Button {
                    if showMarker == false {

                        // Open marker on the map
                            withAnimation(.easeInOut) {
                                showMarker = true
                                showCancel = true
                            }

                    } else {
                        
                        DispatchQueue.main.async {
                            // Show Add New Holiday View
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                    addNewHoliday = true
                                }
                                withAnimation(.default.delay(0.2)) {
                                    showAddNewHolidayContent = true
                                }
                        }
                        
                    }

                } label: {

                    ZStack {

                        Image(systemName: "plus")
                            .resizable()
                            .matchedGeometryEffect(id: "plus", in: namespace)
                            .foregroundColor(Color("PrimaryGreen"))
                            .scaledToFit()
                            .frame(width: 25, height: 25)

                    }


                }
                .padding(20)
                .mask {
                    RoundedRectangle(cornerRadius: 35, style: .continuous)
                        .matchedGeometryEffect(id: "maskAddNew", in: namespace)
                }
                .background(
                    RoundedRectangle(cornerRadius: 35, style: .continuous)
                        .matchedGeometryEffect(id: "addbg", in: namespace)
                        .foregroundColor(Color("ButtonBackground"))
                        .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)

                )
                .padding(.trailing, showMarker ? 20 : 40)

            }


        }
        .padding(.bottom, 55)

    }
    
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        let vm = HolidayViewModel()
//        MapView()
//            .environmentObject(vm)
//    }
//}
