//
//  HomeView2.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 23/06/2022.
//

import SwiftUI
import MapKit

struct HomeView2: View {
    
    @EnvironmentObject var holidayvm: HolidayViewModel
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 160, longitudeDelta: 160))
    
    @State var searchText = ""
    @State var locations = [Location]()
    @State var searchLocation = [Location]()
    
    @State var openSearch = false
    @State var showSearchContent = false
    
    @State var addNew = false
    @State var showAddNewContent = false
    
    @State var holidayName = ""
    @State var holidayCity = ""
    @State var holidayCountry = ""
    @State var holidayDate = Date()
    
    @Namespace var namespace
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack {
            
            HStack {
                
                Button {
                    
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .font(.title)
                        .foregroundColor(Color("Green2"))
                        .padding(15)
                        .background(
                            Circle()
                                .foregroundColor(.white)
                                .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)

                        )
                }
                .frame(width: 40, height: 40)
                .offset(x: (openSearch || addNew) ? -60 : 0)
                
                Spacer()
                
                searchButton
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .font(.title)
                        .foregroundColor(Color("Green2"))
                        .padding(15)
                        .background(
                            Circle()
                                .foregroundColor(.white)
                                .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)

                        )
                }
                .frame(width: 40, height: 40)
                .offset(x: (openSearch || addNew) ? 60 : 0)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(20)
            .padding(.top, 40)
            
            MapView(region: $region)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                .frame(height: Constants.screenHeight / 1.18)
                .frame(maxHeight: .infinity, alignment: .bottom)
            
            newHolidayButton
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            
            VStack {
                
                if openSearch {
                    searchView
                } else if addNew {
                    newHolidayView
                } else {
                   
                }
                
                Spacer()
                
            }
            .frame(maxHeight: .infinity)
            
        
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(
//            Color("Green3").opacity(0.1)
            LinearGradient(colors: [Color("Green3").opacity(0.1), Color("Green3").opacity(0.2)], startPoint: .top, endPoint: .bottom)
        )
    }
    
    var searchButton: some View {
        Button {
            DispatchQueue.main.async {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    openSearch.toggle()
                }
                withAnimation(.default.delay(0.2)) {
                    showSearchContent.toggle()
                }
                
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    addNew = false
                }
                withAnimation(.default.delay(0.3)) {
                    showAddNewContent = false
                }
            }
            
        } label: {
            Text("SEARCH")
                .matchedGeometryEffect(id: "search", in: namespace)
                .foregroundColor(Color("Green2"))
                .font(.callout)
                .padding(6)
                .padding(.horizontal)
                .mask {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .matchedGeometryEffect(id: "mask", in: namespace)
                }
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .foregroundColor(.white)
                        .matchedGeometryEffect(id: "bg", in: namespace)
                        .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                )
            
        }

    }

    var searchView: some View {
        VStack {
            
            HStack {
                
                Button {
                    
                    DispatchQueue.main.async {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            openSearch.toggle()
                        }
                        withAnimation {
                            showSearchContent.toggle()
                        }
                    }
                
                } label: {
                    Image(systemName: "chevron.left")
                }
                .opacity(showSearchContent ? 1 : 0)
                .offset(y: showSearchContent ? 0 : -10)
                
                TextField("Enter Location", text: $searchText)
                    .padding(5)
                    .background(
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .foregroundColor(.gray.opacity(0.08))
                    )
                    .opacity(showSearchContent ? 1 : 0)
                    .offset(y: showSearchContent ? 0 : -10)
                
                
                Button {
                    searchLocation = [Location]()
                    searchText = ""
                } label: {
                    Image(systemName: "xmark")
                }
                .opacity(showSearchContent ? 1 : 0)
                .offset(y: showSearchContent ? 0 : -10)
                
                
                Button {
                    if !searchText.isEmpty {
                        DispatchQueue.main.async {
                            LocationManager.shared.findLocations(with: searchText) { locations in
                                print(locations)
                                    self.searchLocation = locations
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
            .padding(.horizontal, 25)
            .padding(.top, 60)
            .padding(.bottom, 10)
            
            VStack {
                ForEach(searchLocation) { location  in
                    
                    Button {
                        DispatchQueue.main.async {
                            
                            guard let coordinates = location.coordinates else { return }
                            
                            holidayCity = location.city
                            holidayCountry = location.country
                            
                            withAnimation {
                                region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2))
                            }
                            withAnimation {
                                openSearch.toggle()
                            }
                            withAnimation {
                                showSearchContent.toggle()
                            }

                        }

                    } label: {
                        VStack {
                            Text(location.city)
                            
                            Text(location.country)
                                .foregroundColor(location.city.isEmpty ? .primary : .secondary)
                            
                        }

                    }

                    
                }
            }
            .opacity(showSearchContent ? 1 : 0)
            .offset(y: showSearchContent ? 0 : -10)
            
            
            Spacer()
        }
        .foregroundColor(Color("Green2"))
        .frame(maxWidth: .infinity)
        .frame(height: 160)
        .mask {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .matchedGeometryEffect(id: "mask", in: namespace)
        }
        .background(
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .foregroundColor(.white)
//                .foregroundStyle(
//                    LinearGradient(colors: [Color("Green1"), Color("Green1"), Color("Green1"), Color("Green2")], startPoint: .topLeading, endPoint: .bottomTrailing)
//                )
                .matchedGeometryEffect(id: "bg", in: namespace)
                .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)

        )

    }
    
    var newHolidayButton: some View {
        HStack {
            
            Spacer()
            
            Button {
                DispatchQueue.main.async {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        addNew.toggle()
                    }
                    withAnimation(.default.delay(0.3)) {
                        showAddNewContent.toggle()
                    }
                    
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        openSearch = false
                    }
                    withAnimation(.default.delay(0.2)) {
                        showSearchContent = false
                    }
                }
                
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .matchedGeometryEffect(id: "plus", in: namespace)
                    .foregroundColor(Color("Green2"))
                    .frame(width: 30, height: 30)
                
            }
            .padding(15)
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
            .padding(.bottom, 70)
            .padding(.trailing, 50)
            
        }
    }
    
    var newHolidayView: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            HStack {
                
                TextField("Holiday Name", text: $holidayName)
                    .opacity(showAddNewContent ? 1 : 0)
                    .offset(y: showAddNewContent ? 0 : -10)

                
                Spacer()
                
                Button {
                    DispatchQueue.main.async {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            addNew.toggle()
                        }
                        withAnimation {
                            showAddNewContent.toggle()
                        }
                    }
                    
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color("Green1"))
                }
                .opacity(showAddNewContent ? 1 : 0)
                .offset(y: showAddNewContent ? 0 : -10)
                
            }


            VStack(alignment: .leading, spacing: 5) {

                Text("Holiday Location")

                HStack {

                    TextField("City", text: $holidayCity)

                    TextField("Country", text: $holidayCountry)


                    Spacer()

                }

            }
            .opacity(showAddNewContent ? 1 : 0)
            .offset(y: showAddNewContent ? 0 : -10)

            DatePicker("Holiday Date", selection: $holidayDate, displayedComponents: .date)
                .datePickerStyle(.automatic)
                .opacity(showAddNewContent ? 1 : 0)
                .offset(y: showAddNewContent ? 0 : -10)

            
            HStack {
                
                Spacer()

                
                Button {
                    DispatchQueue.main.async {
                        //
                        holidayvm.holidays.append(
                            Holiday(
                                name: holidayName,
                                date: holidayDate,
                                location: Location(
                                    city: holidayCity,
                                    country: holidayCountry,
                                    coordinates: CLLocationCoordinate2D(latitude: region.center.latitude, longitude: region.center.longitude))
                            )
                        )

                    }
                 
                    
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        addNew.toggle()
                    }
                    withAnimation {
                        showAddNewContent.toggle()
                    }
                    
                    
                    //                    holidayName = ""
                    //                    holidayDate = Date()
                    //                    holidayCity = ""
                    //                    holidayCountry = ""
                    
                } label: {
                    
                    Image(systemName: "plus")
                        .resizable()
                        .matchedGeometryEffect(id: "plus", in: namespace)
                        .foregroundColor(Color("Green2"))
                        .frame(width: 30, height: 30)
                }
                
                Spacer()
                
            }
        }
        .foregroundColor(Color("Green2"))
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 25)
        .padding(.top, 60)
        .padding(.bottom, 20)
        .mask {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .matchedGeometryEffect(id: "maskAddNew", in: namespace)
        }
        .background(
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .foregroundColor(.white)
                .matchedGeometryEffect(id: "addbg", in: namespace)
        )
    }

}

struct HomeView2_Previews: PreviewProvider {
    static var previews: some View {
        let vm = HolidayViewModel()
        HomeView2()
            .environmentObject(vm)
    }
}
