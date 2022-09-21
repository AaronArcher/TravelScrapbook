//
//  SearchView.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 20/09/2022.
//

import SwiftUI
import MapKit

struct SearchView: View {
    
    @EnvironmentObject var mapvm: MapViewModel
    
    @Binding var showSearch: Bool
    @Binding var showSearchContent: Bool
    
    @State var searchText = ""
    @State var searchLocations = [Location]()
    
    @Binding var holidayCity: String
    @Binding var holidayCountry: String
    
    let namespace: Namespace.ID
    
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        showSearchContent = false
                    }
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        showSearch = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                }
                .opacity(showSearchContent ? 1 : 0)
                .offset(y: showSearchContent ? 0 : -10)
                .padding(.trailing, 5)
                
                ZStack {
                    
                    TextField("Enter Location", text: $searchText)
                        .padding(5)
                        .background(
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .foregroundColor(.gray.opacity(0.08))
                        )
                    
                    Button {
                        withAnimation(.spring()) {
                            searchLocations = [Location]()
                            searchText = ""
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 15)
                            .foregroundColor(.gray.opacity(0.8))
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 10)
                    
                }
                .frame(height: 30)
                .opacity(showSearchContent ? 1 : 0)
                .offset(y: showSearchContent ? 0 : -10)
                .padding(.trailing, 5)
                
                Button {
                    if !searchText.isEmpty {
                        DispatchQueue.main.async {
                            LocationManager.shared.findLocations(with: searchText) { locations in
                                print(locations)
                                withAnimation(.spring()) {
                                    self.searchLocations = locations
                                }
                            }
                        }
                    }
                } label: {
                    Text("SEARCH")
                        .foregroundColor(Color("Green2"))
                        .matchedGeometryEffect(id: "search", in: namespace)
                        .font(.callout)
                        .foregroundColor(Color("Green2"))
                }
                
            }
            .padding(.horizontal)
            .padding(.top, Constants.isScreenLarge ? 60 : 40)
            .padding(.bottom, 10)
            
            ForEach(searchLocations) { location  in
                
                Button {
                    withAnimation {
                        showSearch = false
                    }
                    withAnimation {
                        showSearchContent = false
                    }
                    
                    DispatchQueue.main.async {
                        holidayCity = location.city
                        holidayCountry = location.country
                        
                        mapvm.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
                    }
                    
                } label: {
                    
                    VStack {
                        Text(location.city)
                        
                        Text(location.country)
                            .foregroundColor(location.city.isEmpty ? .primary : .secondary)
                        
                    }
                }
            }
            .opacity(showSearchContent ? 1 : 0)
            .offset(y: showSearchContent ? 0 : -10)
        }
        .foregroundColor(Color("Green2"))
        .frame(maxWidth: .infinity)
        .padding(.bottom)
        .frame(minHeight: 135)
        .mask {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .matchedGeometryEffect(id: "mask", in: namespace)
        }
        .background(
            Color.white
                .clippedCornerShape(25, corners: [.bottomLeft, .bottomRight])
                .matchedGeometryEffect(id: "bg", in: namespace)
                .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
        )
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
