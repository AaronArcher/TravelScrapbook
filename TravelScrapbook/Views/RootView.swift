//
//  HomeView.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 23/06/2022.
//

import SwiftUI
import MapKit

struct RootView: View {
    
    @EnvironmentObject var holidayvm: HolidayViewModel
    @EnvironmentObject var mapvm: MapViewModel
    
    
    @State var searchText = ""
    @State var locations = [Location]()
    @State var searchLocation = [Location]()
    
    @State var openSearch = false
    @State var showSearchContent = false
    
    @State var addNewHoliday = false
    @State var showAddNewHolidayContent = false
    
    @State var holidayTitle = ""
    @State var holidayCity = ""
    @State var holidayCountry = ""
    @State var holidayDate = Date()
    
    @Namespace var namespace
    @FocusState var isFocused: Bool
    
    @State var showMap = true
    @State var showHoliday = false
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showImagePicker = false
    
    @State var showMarker = false
    @State var showCancel = false
    
    var body: some View {
        ZStack {
            
            HStack {
                
                Button {
                    
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .padding(11)
                        .background(
                            Circle()
                                .foregroundColor(.white)
                                .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)

                        )
                }
                .offset(x: (openSearch || addNewHoliday) ? -80 : 0)
                
                Spacer()
                
                if !openSearch {
                    searchButton
                        .offset(y: addNewHoliday ? -80 : 0)
                        .disabled(!showMap)
                        .opacity(showMap ? 1 : 0.5)
                }
               
                
                Spacer()
                
                Button {
                        withAnimation {
                            showMap.toggle()
                        }
                    
                } label: {
                    
                    ZStack {
                        
                        Image(systemName: "map")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .offset(x: showMap ? -80 : 0)
                        
                        Image(systemName: "list.bullet")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .offset(x: showMap ? 0 : 80)
                        
                    }
                    .padding(11)
                    .mask({
                        Circle()
                    })
                    .background(
                        Circle()
                            .foregroundColor(.white)
                            .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                    )
                    
                }
                .offset(x: (openSearch || addNewHoliday) ? 80 : 0)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(15)
            .padding(.top, Constants.isScreenLarge ? 40 : 20)
            
            
            ZStack {
                mapOrList
            }
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            .padding(.horizontal, 15)
            .padding(.bottom, Constants.isScreenLarge ? 30 : 15)
            .frame(maxHeight: Constants.screenHeight / 1.18)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .shadow(color: Color("Green2").opacity(0.3), radius: 15, x: 5, y: 5)
            .overlay {
                if addNewHoliday || openSearch {
                    Color.gray.opacity(0.5)
                }
            }

            
            
            
            VStack {
                
                if openSearch {
                    
                    // Show search pop up
                    searchView
                    
                } else if addNewHoliday {

                    // Show add new holiday pop up
                    AddNewHoliday(addNewHoliday: $addNewHoliday,
                                  showAddNewHolidayContent: $showAddNewHolidayContent,
                                  showMarker: $showMarker,
                                  showCancel: $showCancel,
                                  showImagePicker: $showImagePicker,
                                  holidayTitle: $holidayTitle,
                                  holidayCity: $holidayCity,
                                  holidayCountry: $holidayCountry,
                                  holidayDate: $holidayDate,
                                  namespace: namespace)

                    
                } else {
                   
                }
                
                Spacer()
                
            }
            .frame(maxHeight: .infinity)

        
        }
        .foregroundColor(Color("Green1"))
        .ignoresSafeArea()
        .background(
//            Color("Green3").opacity(0.1)
            LinearGradient(colors: [Color("Green3").opacity(0.05), Color("Green3").opacity(0.12)], startPoint: .top, endPoint: .bottom)
        )
//        .sheet(isPresented: $showImagePicker) {
//            ImagePicker(image: $inputImage)
//        }
//        .onChange(of: inputImage) { _ in loadImage() }
        
    }
    
    var searchButton: some View {
        Button {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    openSearch = true

                }
                withAnimation(.default.delay(0.2)) {
                    showSearchContent = true
                }
            
        } label: {
            Text("SEARCH")
                .matchedGeometryEffect(id: "search", in: namespace)
                .foregroundColor(Color("Green1"))
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
                    
                    withAnimation(.easeInOut(duration: 0.1)) {
                        showSearchContent.toggle()
                    }
                    
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            openSearch.toggle()
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
            .padding(.top, Constants.isScreenLarge ? 60 : 40)
            .padding(.bottom, 10)
            
            VStack {
                ForEach(searchLocation) { location  in
                    
                    Button {
                        
                        withAnimation {
                            openSearch.toggle()
                        }
                        withAnimation {
                            showSearchContent.toggle()
                        }
                        
                        DispatchQueue.main.async {
                            
                            guard let coordinates = location.coordinates else { return }
                            
                            holidayCity = location.city
                            holidayCountry = location.country
                            
                            mapvm.region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
                           

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
        .padding(.bottom)
        .frame(maxHeight: 160)
        .mask {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .matchedGeometryEffect(id: "mask", in: namespace)
        }
        .background(
            
            Color.white
                .cornerRadius(25, corners: [.bottomLeft, .bottomRight])
                .matchedGeometryEffect(id: "bg", in: namespace)
                .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)

        )

    }
        

    
    @ViewBuilder
    var mapOrList: some View {
        
        if showMap {
            MapView(namespace: namespace,
                    showMarker: $showMarker,
                    showCancel: $showCancel,
                    openSearch: $openSearch,
                    showSearchContent: $showSearchContent,
                    addNewHoliday: $addNewHoliday,
                    showAddNewHolidayContent: $showAddNewHolidayContent)
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
        } else {
            ListView(showHoliday: $showHoliday)
                .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
        }
        
    }
    
//    func loadImage() {
//        guard let inputImage = inputImage else { return }
//        image = Image(uiImage: inputImage)
//    }

}

struct HomeView2_Previews: PreviewProvider {
    static var previews: some View {
        let vm = HolidayViewModel()
        RootView()
            .environmentObject(vm)
    }
}
