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
    @EnvironmentObject var mapvm: MapViewModel
    

    @Binding var addNewHoliday: Bool
    @Binding var showAddNewHolidayContent: Bool
    @Binding var showMarker: Bool
    @Binding var showCancel: Bool
    @Binding var showImagePicker: Bool
    
//    @State var mainImage: Image?
//    @State var allImages: [Image] = []
    
    @State var thumbnailImage: UIImage?

    
    @Binding var holidayTitle: String
    @Binding var holidayCity: String
    @Binding var holidayCountry: String
    @Binding var visitedWith: String
    @Binding var holidayDate: Date
    
    let namespace: Namespace.ID
    
    @State private var category = "Visited"

    @FocusState private var titleFocused: Bool
    @FocusState private var cityFocused: Bool
    @FocusState private var countryFocused: Bool
    @FocusState private var visitedWithFocused: Bool

    @State private var isSaving = false
    
    @State private var infoContentSize: CGFloat = .zero
    
    @State private var showalert = false
    @State private var errorMessage: String?
    
    
    var body: some View {

        VStack {

            ZStack {
                VStack(alignment: .leading) {
                    
                    // Close button, category picker and save button
                    HStack {

                        Button {

                            withAnimation(.easeInOut(duration: 0.1)) {
                                showAddNewHolidayContent.toggle()
                            }
                            
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                    addNewHoliday.toggle()
                                }
                            

                        } label: {

                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 17, height: 17)
                                .foregroundColor(.red)
                        }
                        .frame(width: 20, height: 20)
                        .disabled(isSaving)
                        
                        Spacer()
                        
                        segmentBar

                        Spacer()
                        
                            // Add button
                            Button {
                                titleFocused = false
                                cityFocused = false
                                countryFocused = false
                                visitedWithFocused = false
                                isSaving = true
                            
                                                                
                                if category == "Visited" {
                                    // Save Visited item
                                    DispatchQueue.main.async {
                                        DatabaseService().createHoliday(title: holidayTitle, date: holidayDate, locationID: UUID().uuidString, city: holidayCity, country: holidayCountry, latitude: mapvm.region.center.latitude, longitude: mapvm.region.center.longitude, visitedWith: visitedWith, thumbnailImage: thumbnailImage) { success, error in
                                            
                                            if success {
                                                
                                                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                                    addNewHoliday.toggle()
                                                    showMarker = false
                                                    showCancel = false
                                                }
                                                withAnimation {
                                                    showAddNewHolidayContent.toggle()
                                                }
                                                
                                                holidayTitle = ""
                                                holidayDate = Date()
                                                holidayCity = ""
                                                holidayCountry = ""
                                                
                                                
                                            }
                                            else {
                                                //  Show error
                                                isSaving = false
                                                showalert = true
                                                errorMessage = error
                                            }
                                        }
                                    }

                                } else {
                                    // Save wish list item
                                    DispatchQueue.main.async {
                                        DatabaseService().createWishlistHoliday(title: holidayTitle, date: holidayDate, locationID: UUID().uuidString, city: holidayCity, country: holidayCountry, latitude: mapvm.region.center.latitude, longitude: mapvm.region.center.longitude) { success, error in

                                            if success {

                                                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                                    addNewHoliday.toggle()
                                                    showMarker = false
                                                    showCancel = false
                                                }
                                                withAnimation {
                                                    showAddNewHolidayContent.toggle()
                                                }

                                                holidayTitle = ""
                                                holidayCity = ""
                                                holidayCountry = ""
                                                holidayDate = Date()


                                            }
                                            else {
                                                // Show error
                                                isSaving = false
                                                showalert = true
                                                errorMessage = error
                                            }
                                        }
                                    }

                                }
                                

                            } label: {
                                
                                Image(systemName: "plus")
                                    .resizable()
                                    .matchedGeometryEffect(id: "plus", in: namespace)
                                    .frame(width: 20, height: 20)
                            }
                            .foregroundColor(Color("Green1"))
                            .disabled(isSaving)
                            

                    }
                    .padding(.bottom, 10)

                    
                        information
            
                    
                }
                .opacity(showAddNewHolidayContent ? 1 : 0)
                .offset(y: showAddNewHolidayContent ? 0 : -10)
            
                if isSaving {
                    VStack {

                        ProgressView()
                            .tint(Color("Green2"))

                        Text("Saving...")
                            .font(.title)

                    }
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .foregroundColor(.white)
                            .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                        )

                }
            
            }
            .disabled(isSaving)


        }
        .foregroundColor(Color("Green2"))
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 25)
        .padding(.top, Constants.isScreenLarge ? 60 : 40)
        .padding(.bottom, 15)
        .mask {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .matchedGeometryEffect(id: "maskAddNew", in: namespace)
        }
        .background(

            Color.white
                .cornerRadius(25, corners: [.bottomLeft, .bottomRight])
                .matchedGeometryEffect(id: "addbg", in: namespace)
                .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)

        )
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $thumbnailImage)
        }
        .alert(errorMessage ?? "", isPresented: $showalert) {
            Button("OK", role: .cancel) { }
        }


    }
    
    @ViewBuilder
    var segmentBar: some View {
        let options = ["Visited", "Wish List"]
        
        HStack(spacing: 20) {
            
            Spacer()
            
            
            ForEach(options, id: \.self) { tab in

                if category == tab {
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
                                category = tab
                            }
                        }
                }

            }
            
            Spacer()
            
        }
        
    }
    
    var information: some View {
                
            VStack(alignment: .leading, spacing: 10) {
            
            // Title
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
                
                // City and Country
                HStack {
                    
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
                    
                    Spacer()

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
                
            
            }

            if category == "Visited" {
                
                // Title
                VStack(spacing: 0) {
                    TextField("Visited With:", text: $visitedWith)
                        .padding(.vertical, 5)
                        .focused($visitedWithFocused)
                    
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.gray.opacity(0.5))
                            .cornerRadius(5)
                        
                        Rectangle()
                            .frame(height: 2)
                            .frame(maxWidth: visitedWithFocused || !visitedWith.isEmpty ? .infinity : 0)
                            .animation(.easeInOut, value: visitedWithFocused)
                            .foregroundColor(Color("Green1"))
                            .cornerRadius(5)

                    }
                    .padding(.trailing)
                }
                
                thumbnailImageSection
                    .padding(.vertical, 5)
                
                DatePicker("Holiday Date", selection: $holidayDate, displayedComponents: .date)
                    .datePickerStyle(.automatic)
                    .accentColor(Color("Green1"))
                    .foregroundColor(Color("Green1"))

                
            }
                
            
        }
        
    }
    
    var thumbnailImageSection: some View {
        
        HStack {
            
            Text("Thumbnail Image")
                .foregroundColor(Color("Green1"))
            
            Spacer()
            
            VStack(spacing: 5) {
                Button {
                    
                    showImagePicker = true
                    
                } label: {
                    
                    if thumbnailImage == nil {
                        
                        ZStack {
                        
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color("Green1").opacity(0.2))
                                .frame(width: 90, height: 90)

                            Image(systemName: "photo.fill")
                                .font(.title)
                                .foregroundColor(Color("Green2"))
                            
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .strokeBorder(Color("Green1"), lineWidth: 1)
                                .frame(width: 90, height: 90)

                        }
                        
                    } else {
                        Image(uiImage: thumbnailImage!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 90, height: 90)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .strokeBorder(Color("Green1"), lineWidth: 1)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                    
            }
                
                if thumbnailImage != nil {
                    Button {
                        thumbnailImage = nil
                    } label: {
                        Text("Clear")
                            .foregroundColor(Color("Green1"))
                            .font(.caption)
                    }

                }
                
            }
            

            
        }
        
    }
    
    
}


