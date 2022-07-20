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
    let namespace: Namespace.ID
    
    @Binding var region: MKCoordinateRegion
    @Binding var showMarker: Bool
    @Binding var showCancel: Bool
    
    @Binding var openSearch: Bool
    @Binding var showSearchContent: Bool
    
    @Binding var addNew: Bool
    @Binding var showAddNewContent: Bool
    
    var body: some View {
        
        ZStack {
            Map(coordinateRegion: $region, annotationItems: holidayvm.holidays) { holiday in
                MapAnnotation(coordinate: holiday.location.coordinates ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)) {
                    MapAnnotationView(holiday: holiday, region: $region)
                }
            }
                .disabled(addNew)
                
            Image(systemName: "mappin")
                .resizable()
                .matchedGeometryEffect(id: "pin", in: namespace)
                .foregroundColor(Color("Green1"))
                .scaledToFit()
                .frame(width: 24, height: 24)
                .offset(y: -12)
                .scaleEffect(showMarker ? 1 : 0.001) // The "0.001 removed 'ignoring singular matric error in console
            
                Text("Confirm your holiday location")
                    .font(.footnote)
                    .foregroundColor(Color("Green1"))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .foregroundColor(.white)
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
                    .foregroundColor(.white)
                    .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)

            )
            .transition(.scale)
            .scaleEffect(addNew ? 0.001 : 1)
            }


            if !addNew {
                Button {
                    if showMarker == false {
                        DispatchQueue.main.async {
                            withAnimation(.easeInOut) {
                                showMarker = true
                                showCancel = true
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                addNew.toggle()
                                openSearch = false
                            }
                            withAnimation(.default.delay(0.2)) {
                                showAddNewContent.toggle()
                                showSearchContent = false

                            }
                        }
                    }

                } label: {

                    ZStack {

                        Image(systemName: "plus")
                            .resizable()
                            .matchedGeometryEffect(id: "plus", in: namespace)
                            .foregroundColor(Color("Green1"))
                            .scaledToFit()
                            .frame(width: 25, height: 25)
//                            .offset(y: showMarker ? 80 : 0)



//                        Image(systemName: "checkmark")
//                            .resizable()
//                            .matchedGeometryEffect(id: "checkmark", in: namespace)
//                            .scaledToFit()
//                            .foregroundColor(Color("Green1"))
//                            .frame(width: 30, height: 30)
//                            .offset(y: showMarker ? 0 : -80)
//                            .scaleEffect(addNew ? 0.001 : 1)

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
                        .foregroundColor(.white)
                        .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)

                )
                .padding(.trailing, showMarker ? 20 : 40)

            }
            
            
        }
        .padding(.bottom, 40)
        
    }
    
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        let vm = HolidayViewModel()
//        MapView()
//            .environmentObject(vm)
//    }
//}
