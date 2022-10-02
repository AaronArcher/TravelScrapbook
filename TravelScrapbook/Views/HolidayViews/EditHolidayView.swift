//
//  EditHolidayView.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 02/08/2022.
//

import SwiftUI

struct EditHolidayView: View {
    
    @Environment(\.dismiss) private var dismiss


    let holiday: Holiday
    
    @State private var visited = false
    
    @State private var newTitle = ""
    @State var newDate: Date
    @State private var newVisitedWith = ""
    @State private var newCity = ""
    @State private var newCountry = ""
    @State private var newThumbnail: UIImage?
    
    @FocusState private var titleFocused: Bool
    @FocusState private var visitedWithFocused: Bool
    @FocusState private var cityFocused: Bool
    @FocusState private var countryFocused: Bool

    @State private var showImagePicker = false
    @State private var showDelete = false


    var body: some View {
        
        VStack {
            
            HStack {
                
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .font(.callout)
                        .foregroundColor(.red)
                }
                
                Spacer()
                
                // Save button
                    
                    Button {
                        
                        titleFocused = false
                        visitedWithFocused = false
                        cityFocused = false
                        countryFocused = false
                        
                        if holiday.isWishlist {
                            
                            // Edit a wishlist holiday
                            if !visited {
                                
                                // TODO: Update existing wishlist
                                DatabaseService().editWishlistHoliday(holiday: holiday, title: newTitle, city: newCity, country: newCountry) { success, error in
                                    
                                    if success {
                                        dismiss()
                                        print("success updating wishlist")
                                    } else {
                                        // TODO: Handle error
                                        
                                    }
                                    
                                }
                                
                            } else {
                                
                                // If changing to a Visited holiday, save new visited holiday and delete this from wishlist
                                DatabaseService().createHoliday(title: newTitle == "" ? holiday.title : newTitle,
                                                                date: newDate,
                                                                locationID: holiday.location.id,
                                                                city: newCity == "" ? holiday.location.city : newCity,
                                                                country: newCountry == "" ? holiday.location.country : newCountry,
                                                                latitude: holiday.location.latitude,
                                                                longitude: holiday.location.longitude,
                                                                visitedWith: newVisitedWith,
                                                                thumbnailImage: newThumbnail) { success, error in
                                    
                                    if success {
                                        
                                        DatabaseService().deleteHoliday(holiday: holiday) { success, error in
                                            
                                            if success {
                                            
                                                dismiss()
                                                print("Success in deleting holiday")
                                                
                                            } else {
                                                // TODO: Handle error
                                                print(" Failure deleting holiday - \(error ?? "")")
                                            }
                                            
                                        }
                                        
                                    } else {
                                        // TODO: Handle error
                                        print("Something went wrong creating new holiday")
                                    }
                                    
                                }
                                
                            }
                                                        
                            
                        } else {
                            
                            // Editing a visited holiday
                            DatabaseService().editVisitedHoliday(holiday: holiday, title: newTitle, visitedWith: newVisitedWith, city: newCity, country: newCountry, date: newDate, newImage: newThumbnail) { success, error in
                                
                                if success {
                                    
                                    dismiss()
                                    
                                } else {
                                    // TODO: Show error
                                    
                                }
                                
                                
                            }
                            
                        }
                        
                        
                    } label: {
                        Text("Update")
                            .font(.callout)
                    }
                    
                
            }
            .padding(.top)
            .padding(.horizontal)
            
            ScrollView {
                
                if holiday.isWishlist {
                
                    Toggle("Visited this destination?", isOn: $visited)
                        .padding(.horizontal, 32)
                        .padding(.top)
                }
                
                // Title
                HStack {
                    Text("Title:")
                    
                    TextField(holiday.title, text: $newTitle)
                        .focused($titleFocused)
                        .multilineTextAlignment(.leading)

                }
                .padding(.horizontal)
                .padding(.vertical, 5)
                .background(
                        TextBackground(isTextfield: true, isFocused: titleFocused)
                )
                .padding(.horizontal)
                .padding(.vertical, 10)
                .padding(.top, !holiday.isWishlist ? 16 : 0)


                // City
                HStack {
                    Text("City:")
                    
                    TextField(holiday.location.city, text: $newCity)
                        .focused($cityFocused)
                        .multilineTextAlignment(.leading)

                }
                .padding(.horizontal)
                .padding(.vertical, 5)
                .background(
                        TextBackground(isTextfield: true, isFocused: cityFocused)
                )
                .padding(.horizontal)
                .padding(.vertical, 10)

                
                // Country
                HStack {
                    Text("Country:")
                    
                    TextField(holiday.location.country, text: $newCountry)
                        .focused($countryFocused)
                        .multilineTextAlignment(.leading)

                }
                .padding(.horizontal)
                .padding(.vertical, 5)
                .background(
                        TextBackground(isTextfield: true, isFocused: countryFocused)
                )
                .padding(.horizontal)
                .padding(.vertical, 10)

                // Show Visited with, date and image if this is editing a visited holiday or a wishlist holiday changing to a visited holiday
                if !holiday.isWishlist || (holiday.isWishlist && visited) {

                    // Visited With
                    HStack {
                        Text("Visited with:")
                        
                        TextField(holiday.visitedWith ?? "", text: $newVisitedWith)
                            .focused($visitedWithFocused)
                            .multilineTextAlignment(.leading)

                    }
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .background(
                            TextBackground(isTextfield: true, isFocused: visitedWithFocused)
                    )
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    
                    
                    // Date
                    DatePicker("Holiday Date", selection: $newDate, displayedComponents: .date)
                        .datePickerStyle(.automatic)
                        .accentColor(Color("Green1"))
                        .foregroundColor(Color("Green1"))
                        .padding()

                    // Image
                    
                    HStack {
                        
                        Text("Thumbnail Image:")
                            .foregroundColor(Color("Green1"))
                        
                        Spacer()
                        
                        VStack(spacing: 5) {
                            
                            Button {
                                
                                showImagePicker = true
                                
                            } label: {
                                
                                if newThumbnail == nil {
                                    MainHolidayImage(holiday: holiday, iconSize: 45)
                                        .frame(width: 100, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                                .stroke(Color("Green1"), lineWidth: 1)
                                        )
                                } else {
                                 
                                        Image(uiImage: newThumbnail!)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                                    .strokeBorder(Color("Green1"), lineWidth: 1)
                                            )
                                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                    
                                    
                                }

                            }
                            
                        }

                        
                    }
                    .padding(.horizontal)
                    
                }
                
                Spacer()
                
                if holiday.isWishlist {
                                        
                    Button {
                        
                        showDelete = true
                        
                    } label: {
                        
                        Text("Delete")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .foregroundColor(.red)
                            )
                            .padding(.horizontal)
                            .padding(.vertical, 30)
                        
                    }
                    
                }

                
            }
            
            Spacer()
        
        }
        .foregroundColor(Color("Green1"))
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $newThumbnail)
        }
        .alert("Are you sure you want to delete this destination?", isPresented: $showDelete) {
            Button {
                DatabaseService().deleteHoliday(holiday: holiday) { success, error in
                    if success {
                        dismiss()
                        
                    } else {
                
                    }
                }
            } label: {
                Text("Yes")
            }
            
            Button("Cancel", role: .cancel) { }

        }

        
    }
}

//struct EditHolidayView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditHolidayView()
//    }
//}
