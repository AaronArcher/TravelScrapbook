//
//  AddNewHoliday.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 28/06/2022.
//

import SwiftUI
import MapKit

struct AddNewHoliday: View {
    
    @EnvironmentObject var holidayvm: HolidayViewModel
    
    @Binding var region: MKCoordinateRegion

    @Binding var addNew: Bool
    @Binding var showAddNewContent: Bool
    @Binding var showMarker: Bool
    @Binding var showCancel: Bool
    @Binding var showImagePicker: Bool
    
//    @State var mainImage: Image?
//    @State var allImages: [Image] = []
    
    @State var mainImage: UIImage?

    @State var allImages: [UIImage] = []
    
    @Binding var holidayTitle: String
    @Binding var holidayCity: String
    @Binding var holidayCountry: String
    @Binding var holidayDate: Date
    
    let namespace: Namespace.ID
    
    @State var selectedTab = "Information"

    @FocusState private var titleFocused: Bool
    @FocusState private var cityFocused: Bool
    @FocusState private var countryFocused: Bool

    
    let rows = [
        GridItem(.fixed(90)),
            GridItem(.fixed(90))
        ]
    
    
    var body: some View {

        VStack {

            VStack(alignment: .leading) {
                
                HStack {

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
                            .font(.callout)
                    }

                    Spacer()

                }
                
                segmentBar
                    .padding(.bottom, 10)
                
                if selectedTab == "Information" {
                    information
                } else {
                    gallery
                }
        
                
            }
            .opacity(showAddNewContent ? 1 : 0)
            .offset(y: showAddNewContent ? 0 : -10)


            HStack {

                Spacer()


                Button {
                    DispatchQueue.main.async {
                        //
                        holidayvm.holidays.append(
                            Holiday(
                                title: holidayTitle,
                                date: holidayDate,
                                location: Location(
                                    city: holidayCity,
                                    country: holidayCountry,
                                    coordinates: CLLocationCoordinate2D(latitude: region.center.latitude, longitude: region.center.longitude)),
                                mainImage: mainImage,
                                allImages: allImages
                            )
                        )

                    }


                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        addNew.toggle()
                        showMarker = false
                        showCancel = false
                    }
                    withAnimation {
                        showAddNewContent.toggle()
                    }


                    //                    holidayName = ""
                    //                    holidayDate = Date()
                    //                    holidayCity = ""
                    //                    holidayCountry = ""

                } label: {

                    HStack {
                        
                        Text("Create")
                            .font(.title2)
                            .opacity(showAddNewContent ? 1 : 0)
                            .offset(y: showAddNewContent ? 0 : -10)
                        
                        Image(systemName: "plus")
                            .resizable()
                            .matchedGeometryEffect(id: "plus", in: namespace)
                            .frame(width: 25, height: 25)
                    }
                    .foregroundColor(Color("Green1"))

                }
                .padding(.top)

                Spacer()

            }
        }
        .foregroundColor(Color("Green2"))
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 25)
        .padding(.top, Constants.isScreenLarge ? 60 : 40)
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
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(images: $allImages)
        }
//        .onChange(of: inputImages) { _ in loadImage() }



    }
    
    @ViewBuilder
    var segmentBar: some View {
        let options = ["Information", "Gallery"]
        
        HStack(spacing: 30) {
            
            Spacer()
            
            ForEach(options, id: \.self) { tab in
                
                if selectedTab == tab {
                    Text(tab)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color("Green1"))
                                .matchedGeometryEffect(id: "tab", in: namespace)
                        )
                        

                } else {
                    Text(tab)
                        .foregroundColor(Color("Green1"))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.clear)
                        )
                        .onTapGesture {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                selectedTab = tab
                            }
                        }
                }
                
            }
            
            Spacer()
            
        }
        
    }
    
    var information: some View {
                
        VStack(alignment: .leading, spacing: 10) {
            

            VStack(spacing: 0) {
                TextField("Holiday Title", text: $holidayTitle)
                    .padding(.vertical, 5)
                    .focused($titleFocused)
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.gray.opacity(0.5))
                        .cornerRadius(5)
                    
                    Rectangle()
                        .frame(height: 2)
                        .frame(maxWidth: titleFocused || !holidayTitle.isEmpty ? .infinity : 0)
                        .animation(.easeInOut, value: titleFocused)
                        .foregroundColor(Color("Green1"))
                        .cornerRadius(5)

                }
                .padding(.trailing)
            }
                

            VStack(spacing: 0) {
                TextField("City", text: $holidayCity)
                    .padding(.vertical, 5)
                    .focused($cityFocused)
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.gray.opacity(0.5))
                        .cornerRadius(5)
                    
                    Rectangle()
                        .frame(height: 2)
                        .frame(maxWidth: cityFocused || !holidayCity.isEmpty ? .infinity : 0)
                        .animation(.easeInOut, value: cityFocused)
                        .foregroundColor(Color("Green1"))
                        .cornerRadius(5)

                }
                .padding(.trailing)
            }

            VStack(spacing: 0) {
                TextField("Country", text: $holidayCountry)
                    .padding(.vertical, 5)
                    .focused($countryFocused)
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.gray.opacity(0.5))
                        .cornerRadius(5)
                    
                    Rectangle()
                        .frame(height: 2)
                        .frame(maxWidth: countryFocused || !holidayCountry.isEmpty ? .infinity : 0)
                        .animation(.easeInOut, value: countryFocused)
                        .foregroundColor(Color("Green1"))
                        .cornerRadius(5)

                }
                .padding(.trailing)
            }

            
                DatePicker("Holiday Date", selection: $holidayDate, displayedComponents: .date)
                    .datePickerStyle(.automatic)
                    .accentColor(Color("Green1"))
            
        }
        
    }
    
    var gallery: some View {
        
        VStack {


            if allImages.count != 0 {
                
                //MARK: Cover Image
                HStack {
                    
                    Spacer()
                    
                    VStack {
                        Text("Cover Image:")
                            .font(.title2)
                        
                        Text("Select an image from your photos below to set your cover image")
                            .font(.caption)
                            .italic()
                            .frame(width: 200)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            
                    }
                    .foregroundColor(Color("Green1"))
                    
                    Spacer()
                    
                    ZStack {
                        
                        Circle()
                            .fill(Color("Green1").opacity(0.2))
                            .frame(width: 90, height: 90)
                        
                        Image(systemName: "photo.fill")
                            .font(.title)
                            .foregroundColor(Color("Green2"))
                        
                        if mainImage != nil {
                            Image(uiImage: mainImage!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 90, height: 90)
                                .overlay(
                                    Circle()
                                        .stroke(Color("Green1"), lineWidth: 2)
                                )
                                .clipShape(Circle())
                        }
                                
                    }
                    
                    Spacer()
                    
                }
                
                Text("All Photos:")
                
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, spacing: 5) {
                        ForEach(allImages, id: \.self) { image in
                        
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 90, height: 90)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                )
                                .onTapGesture {
                                    mainImage = image
                                }
                            
                        }
                    }
                }
            }
            
            Button {
                showImagePicker = true
            } label: {

                HStack {
                    
                    Text("Upload Photos")
                        .font(.title2)
                    
                    Image(systemName: "photo.on.rectangle.angled")
                        .font(.title2)
                }
                    .foregroundColor(Color("Green1"))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .foregroundColor(.white)
                            .shadow(color: Color("Green2").opacity(0.3), radius: 10, x: 5, y: 5)
                    )

            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top)
                

        }
    }
    
//    func loadImage() {
//        guard let inputImage = inputImage else { return }
//        mainImage = Image(uiImage: inputImage)
//    }

    
}


