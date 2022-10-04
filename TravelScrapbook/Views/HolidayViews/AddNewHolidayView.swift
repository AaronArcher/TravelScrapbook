//
//  AddNewHolidayView.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 28/06/2022.
//

import SwiftUI
import MapKit

struct AddNewHolidayView: View {
    
    @EnvironmentObject var holidayvm: HolidayViewModel
    @EnvironmentObject var mapvm: MapViewModel
    
    @Binding var showAddNewHoliday: Bool
    @Binding var showAddNewHolidayContent: Bool
    @Binding var showMarker: Bool
    @Binding var showCancel: Bool
    
    @State var showImagePicker = false
    @State var thumbnailImage: UIImage?
    
    @State var holidayTitle = ""
    @Binding var holidayCity: String
    @Binding var holidayCountry: String
    @State var visitedWith = ""
    @State var holidayDate = Date()
    
    let namespace: Namespace.ID
    
    @State private var category = "Visited"
    
    @FocusState private var titleFocused: Bool
    @FocusState private var cityFocused: Bool
    @FocusState private var countryFocused: Bool
    @FocusState private var visitedWithFocused: Bool
    
    @State private var isSaving = false
    
    @State private var infoContentSize: CGFloat = .zero
    
    @State private var showalert = false
    @State private var errorMessage = ""
    
    
    var body: some View {
        
        VStack {
            ZStack {
                VStack(alignment: .leading) {
                    
                    HStack {
                        
                        Button {
                            
                            withAnimation(.easeInOut(duration: 0.1)) {
                                showAddNewHolidayContent = false
                            }
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                showAddNewHoliday = false
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
                        
                        saveButton
                        
                    }
                    .padding(.bottom, 10)
                    
                    information
                    
                }
                .opacity(showAddNewHolidayContent ? 1 : 0)
                .offset(y: showAddNewHolidayContent ? 0 : -10)
                
                if isSaving {
                    VStack {
                        
                        ProgressView()
                            .tint(Color("PrimaryGreen"))
                        
                        Text("Saving...")
                            .font(.title)
                        
                    }
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .foregroundColor(Color("ButtonBackground"))
                            .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                    )
                }
            }
            .disabled(isSaving)
        }
        .foregroundColor(Color("PrimaryGreen"))
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 25)
        .padding(.top, Constants.isScreenLarge ? 60 : 40)
        .padding(.bottom, 20)
        .mask {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .matchedGeometryEffect(id: "maskAddNew", in: namespace)
        }
        .background(
            Color("Background")
                .clippedCornerShape(25, corners: [.bottomLeft, .bottomRight])
                .matchedGeometryEffect(id: "addbg", in: namespace)
                .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
        )
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $thumbnailImage)
        }
        .alert(errorMessage, isPresented: $showalert) {
            Button("OK", role: .cancel) { }
        }
        
    }
    
    @ViewBuilder
    var segmentBar: some View {
        let options = ["Visited", "Wishlist"]
        
        HStack(spacing: 10) {
                        
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
                        .foregroundColor(Color("PrimaryGreen"))
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
                        
        }
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .foregroundColor(Color("SliderBackground"))
        )
        
    }
    
    var saveButton: some View {
        Button {
            titleFocused = false
            cityFocused = false
            countryFocused = false
            visitedWithFocused = false
            isSaving = true
            
            
            if category == "Visited" {
                
                DatabaseService().createHoliday(title: holidayTitle, date: holidayDate, locationID: UUID().uuidString, city: holidayCity, country: holidayCountry, latitude: mapvm.region.center.latitude, longitude: mapvm.region.center.longitude, visitedWith: visitedWith, thumbnailImage: thumbnailImage) { success, error in
                    
                    if success {
                        
                        DispatchQueue.main.async {
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                showAddNewHoliday = false
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
                        
                    }
                    else {
                        
                        DispatchQueue.main.async {
                            isSaving = false
                            showalert = true
                            errorMessage = error ?? ""
                        }
                    }
                }
                
            } else {
                
                DatabaseService().createWishlistHoliday(title: holidayTitle, date: holidayDate, locationID: UUID().uuidString, city: holidayCity, country: holidayCountry, latitude: mapvm.region.center.latitude, longitude: mapvm.region.center.longitude) { success, error in
                    
                    if success {
                        
                        DispatchQueue.main.async {
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                showAddNewHoliday = false
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
                        
                    } else {
                        
                        DispatchQueue.main.async {
                            isSaving = false
                            showalert = true
                            errorMessage = error ?? ""
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
        .foregroundColor(Color("PrimaryGreen"))
        .disabled(isSaving)
    }
    
    var information: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            HolidayTextField(placeholderText: "Holiday Title", text: $holidayTitle, isFocused: $titleFocused)
            
            HStack {
                
                HolidayTextField(placeholderText: "City", text: $holidayCity, isFocused: $cityFocused)
                                
                Spacer()
                
                HolidayTextField(placeholderText: "Country", text: $holidayCountry, isFocused: $countryFocused)
            }
            
            if category == "Visited" {
                
                HolidayTextField(placeholderText: "Visited With", text: $visitedWith, isFocused: $visitedWithFocused)
                
                thumbnailImageSection
                    .padding(.vertical, 5)
                
                DatePicker("Holiday Date", selection: $holidayDate, displayedComponents: .date)
                    .datePickerStyle(.automatic)
                    .foregroundColor(Color("PrimaryGreen"))
                
            }
        }
    }
    
    var thumbnailImageSection: some View {
        
        HStack {
            
            Text("Thumbnail Image")
                .foregroundColor(Color("PrimaryGreen"))
            
            Spacer()
            
            Button {
                
                showImagePicker = true
                
            } label: {
                
                if thumbnailImage == nil {
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color("Green1").opacity(0.1))
                            .frame(width: 90, height: 90)
                        
                        Image(systemName: "photo.fill")
                            .font(.title)
                            .foregroundColor(Color("PrimaryGreen"))
                        
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
                                .strokeBorder(Color("PrimaryGreen"), lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
            }
        }
    }
    
}
