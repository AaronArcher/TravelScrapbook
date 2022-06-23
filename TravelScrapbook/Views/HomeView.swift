//
//  ContentView.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 13/06/2022.
//

import SwiftUI
import MapKit

struct HomeView: View {
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 160, longitudeDelta: 160))
    
    let holidayvm = HolidayViewModel()
    
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
            
            Map(coordinateRegion: $region, annotationItems: holidayvm.holidays) { holiday in
                MapAnnotation(coordinate: holiday.location.coordinates ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)) {
                    MapAnnotationView(holiday: holiday)
                }
            }
            .disabled(addNew)
            
            Circle()
                .frame(width: 4, height: 4)
                .foregroundColor(.teal)
            
            Button {
                
            } label: {
                Image(systemName: "slider.horizontal.3")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .padding(10)
                    .background(
                        Circle()
                            .foregroundColor(.white)
                    )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(20)
            .padding(.top, 50)
            .offset(x: (openSearch || addNew) ? -60 : 0)
            
            //New Buttons
            VStack {
                // Search Button
                HStack {
                    Spacer()
                    
                    HStack {
                        
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
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .matchedGeometryEffect(id: "mg", in: namespace)
                                .foregroundColor(.teal)
                        }
                        
                        Color.white
                            .frame(width: 30, height: 30)

                        
                    }
                    .padding(12)
                    .padding(.leading,3)
                    .mask {
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .matchedGeometryEffect(id: "mask", in: namespace)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .foregroundColor(.white)
                            .matchedGeometryEffect(id: "bg", in: namespace)
                    )
                    .offset(x: 40)
                    .offset(x: addNew ? 90 : 0)

                    

                }
                .padding(.top, 150)
                
                // Add Button
                HStack {
                    Spacer()
                    
                    HStack {
                        
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
                                .foregroundColor(.teal)
                                .frame(width: 25, height: 25)
                        }
                        
                        Color.white
                            .frame(width: 30, height: 30)

                        
                    }
                    .padding(12)
                    .padding(.leading,3)
                    .mask {
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .matchedGeometryEffect(id: "maskAddNew", in: namespace)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .matchedGeometryEffect(id: "addbg", in: namespace)
                            .foregroundColor(.white)
                    )
                    .offset(x: 40)
                    .offset(x: openSearch ? 90 : 0)
                    

                }
                
                Spacer()
                
            }
            .frame(maxHeight: .infinity)
            
            VStack {
                
//                searchButton
                
                
                
                
                if openSearch {
                    searchView2
                } else if addNew {
                    newHolidayView2
                } else {
                   
                }
//
                
//                if openSearch {
//                    searchView
//                } else {
//                    searchButton
//                }
//
//                if addNew {
//                    newHolidayView
//                }
                
//                Spacer()
                
//                if addNew {
//                    newHolidayView
//                }
                
                Spacer()
                
//                if !addNew {
//                    newHolidayButton
//                }
                
            }
            .frame(maxHeight: .infinity)
            
            
            
        }
        .ignoresSafeArea()
        
        
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
            Text("Search")
                .matchedGeometryEffect(id: "search", in: namespace)
                .padding(5)
                .padding(.horizontal)
                .mask {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .matchedGeometryEffect(id: "mask", in: namespace)
                }
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .foregroundColor(.white)
                        .matchedGeometryEffect(id: "bg", in: namespace)
                )
                .padding(.top, 75)
            
        }

    }
    
//    var searchView: some View {
//        VStack {
//
//            HStack {
//
//                Button {
//
//                    DispatchQueue.main.async {
//                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
//                            openSearch.toggle()
//                        }
//                        withAnimation {
//                            showSearchContent.toggle()
//                        }
//                    }
//
//                } label: {
//                    Image(systemName: "chevron.left")
//                        .foregroundColor(.secondary)
//                }
//                .opacity(showSearchContent ? 1 : 0)
//                .offset(y: showSearchContent ? 0 : -10)
//
//                TextField("Enter Location", text: $searchText)
//                    .padding(5)
//                    .background(
//                        RoundedRectangle(cornerRadius: 5, style: .continuous)
//                            .foregroundColor(.gray.opacity(0.08))
//                    )
//                    .opacity(showSearchContent ? 1 : 0)
//                    .offset(y: showSearchContent ? 0 : -10)
//
//
//                Button {
//                    searchLocation = [Location]()
//                    searchText = ""
//                } label: {
//                    Image(systemName: "xmark")
//                        .foregroundColor(.secondary)
//                }
//                .opacity(showSearchContent ? 1 : 0)
//                .offset(y: showSearchContent ? 0 : -10)
//
//
//                Button {
//                    if !searchText.isEmpty {
//                        LocationManager.shared.findLocations(with: searchText) { locations in
//                            print(locations)
//                            DispatchQueue.main.async {
//                                self.searchLocation = locations
//                            }
//
//                        }
//
//
//                    }
//                } label: {
////                    Text("Search")
////                        .matchedGeometryEffect(id: "search", in: namespace)
//                    Image(systemName: "magnifyingglass")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 25, height: 25)
//                        .matchedGeometryEffect(id: "mg", in: namespace)
//                        .foregroundColor(.teal)
//                }
//
//            }
//            .padding(.horizontal, 25)
//            .padding(.top, 60)
//            .padding(.bottom, 10)
//
//            VStack {
//                ForEach(searchLocation) { location  in
//
//                    Button {
//                        DispatchQueue.main.async {
//
//                            guard let coordinates = location.coordinates else { return }
//
//                            holidayCity = location.city
//                            holidayCountry = location.country
//
//                            withAnimation {
//                                region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2))
//                            }
//                            withAnimation {
//                                openSearch.toggle()
//                            }
//                            withAnimation {
//                                showSearchContent.toggle()
//                            }
//
//                        }
//
//                    } label: {
//                        VStack {
//                            Text(location.city)
//
//                            Text(location.country)
//                                .foregroundColor(location.city.isEmpty ? .primary : .secondary)
//
//                        }
//
//                    }
//
//
//                }
//            }
//            .opacity(showSearchContent ? 1 : 0)
//            .offset(y: showSearchContent ? 0 : -10)
//
//
//            Spacer()
//        }
//        .frame(maxWidth: .infinity)
//        .frame(height: 160)
//        .background(
//            RoundedRectangle(cornerRadius: 15, style: .continuous)
//                .foregroundColor(.white)
//                .matchedGeometryEffect(id: "bg", in: namespace)
//        )
//        .mask {
//            RoundedRectangle(cornerRadius: 15, style: .continuous)
//                .matchedGeometryEffect(id: "mask", in: namespace)
//        }
//
//    }
    
//    var newHolidayView: some View {
//
//        VStack(alignment: .leading, spacing: 20) {
//
//            TextField("Holiday Name", text: $holidayName)
//                .opacity(showAddNewContent ? 1 : 0)
//                .offset(y: showAddNewContent ? 0 : -10)
//
//
//
//            VStack(alignment: .leading, spacing: 5) {
//
//                Text("Holiday Location")
//
//                HStack {
//
//                    TextField("City", text: $holidayCity)
//
//                    TextField("Country", text: $holidayCountry)
//
//
//                    Spacer()
//
//                }
//
//            }
//            .opacity(showAddNewContent ? 1 : 0)
//            .offset(y: showAddNewContent ? 0 : -10)
//
//            DatePicker("Holiday Date", selection: $holidayDate, displayedComponents: .date)
//                .datePickerStyle(.automatic)
//                .opacity(showAddNewContent ? 1 : 0)
//                .offset(y: showAddNewContent ? 0 : -10)
//
//
//            HStack {
//
//                Spacer()
//
//                Button {
//                    DispatchQueue.main.async {
//                        //
//                        holidayvm.holidays.append(
//                            Holiday(
//                                name: holidayName,
//                                date: holidayDate,
//                                location: Location(
//                                    city: holidayCity,
//                                    country: holidayCountry,
//                                    coordinates: CLLocationCoordinate2D(latitude: region.center.latitude, longitude: region.center.longitude))
//                            )
//                        )
//
//                    }
//
//
//                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
//                        addNew.toggle()
//                    }
//                    withAnimation {
//                        showAddNewContent.toggle()
//                    }
//
//
//                    //                    holidayName = ""
//                    //                    holidayDate = Date()
//                    //                    holidayCity = ""
//                    //                    holidayCountry = ""
//
//                } label: {
//
//                    Image(systemName: "plus")
//                        .resizable()
//                        .matchedGeometryEffect(id: "plus", in: namespace)
//                        .foregroundColor(.teal)
//                        .frame(width: 30, height: 30)
//                }
//
//                Spacer()
//
//            }
//        }
//        .frame(width: 250)
//        .padding(.vertical, 20)
//        .padding(.horizontal, 30)
//        .mask {
//            RoundedRectangle(cornerRadius: 25, style: .continuous)
//                .matchedGeometryEffect(id: "maskAddNew", in: namespace)
//        }
//        .background(
//            RoundedRectangle(cornerRadius: 25, style: .continuous)
//                .foregroundColor(.white)
//                .matchedGeometryEffect(id: "addbg", in: namespace)
//        )
//    }
    
    var searchView2: some View {
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
                        .foregroundColor(.secondary)
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
                        .foregroundColor(.secondary)
                }
                .opacity(showSearchContent ? 1 : 0)
                .offset(y: showSearchContent ? 0 : -10)
                
                
                Button {
                    if !searchText.isEmpty {
                        LocationManager.shared.findLocations(with: searchText) { locations in
                            print(locations)
                            DispatchQueue.main.async {
                                self.searchLocation = locations
                            }
                            
                        }
                        
                        
                    }
                } label: {
//                    Text("Search")
//                        .matchedGeometryEffect(id: "search", in: namespace)
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .matchedGeometryEffect(id: "mg", in: namespace)
                        .foregroundColor(.teal)
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
        .frame(maxWidth: .infinity)
        .frame(height: 160)
        .background(
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .foregroundColor(.white)
                .matchedGeometryEffect(id: "bg", in: namespace)
        )
        .mask {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .matchedGeometryEffect(id: "mask", in: namespace)
        }

    }
    var newHolidayView2: some View {
        
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
                        .foregroundColor(.red)
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
                        .foregroundColor(.teal)
                        .frame(width: 30, height: 30)
                }
                
                Spacer()
                
            }
        }
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
                    .foregroundColor(.teal)
                    .frame(width: 30, height: 30)
                
            }
            .padding(10)
            .mask {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .matchedGeometryEffect(id: "maskAddNew", in: namespace)
            }
            .background(
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .matchedGeometryEffect(id: "addbg", in: namespace)
                    .foregroundColor(.white)
            )
            .padding(.bottom, 70)
            .padding(.trailing, 50)
            
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
