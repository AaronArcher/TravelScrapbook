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
                        
                        
                        
                        DatabaseService().editVisitedHoliday(holiday: holiday, title: newTitle, visitedWith: newVisitedWith, city: newCity, country: newCountry, date: newDate, newImage: newThumbnail) { success, error in
                            
                            if success {
                                
                                dismiss()
                                
                            } else {
                                // Show error
                                
                            }
                            
                            
                        }
                        
                    } label: {
                        Text("Save")
                            .font(.callout)
                    }
                    
                
            }
            .padding(.top)
            .padding(.horizontal)
            
            ScrollView {
                
                // Title
                HStack {
                    Text("Title:")
                    
                    TextField(holiday.title, text: $newTitle)
                        .focused($titleFocused)
                        .multilineTextAlignment(.leading)

                }
                    .padding()
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .foregroundColor(.white)
                                .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                                .frame(height: 50)
                            
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .trim(from: 0, to: titleFocused ? 1 : 0)
                                .stroke(Color("Green2"), lineWidth: 1)
                                .frame(height: 50)
                                .animation(.easeInOut(duration: 0.8), value: titleFocused)
                            
                            
                        }
                    )
                    .padding(.horizontal)
                    .padding(.top)

                
                // Visited With
                HStack {
                    Text("Visited with:")
                    
                    TextField(holiday.visitedWith ?? "", text: $newVisitedWith)
                        .focused($visitedWithFocused)
                        .multilineTextAlignment(.leading)

                }
                    .padding()
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .foregroundColor(.white)
                                .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                                .frame(height: 50)
                            
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .trim(from: 0, to: visitedWithFocused ? 1 : 0)
                                .stroke(Color("Green2"), lineWidth: 1)
                                .frame(height: 50)
                                .animation(.easeInOut(duration: 0.8), value: visitedWithFocused)
                            
                            
                        }
                    )
                    .padding(.horizontal)

                // City
                HStack {
                    Text("City:")
                    
                    TextField(holiday.location.city, text: $newCity)
                        .focused($cityFocused)
                        .multilineTextAlignment(.leading)

                }
                    .padding()
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .foregroundColor(.white)
                                .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                                .frame(height: 50)
                            
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .trim(from: 0, to: cityFocused ? 1 : 0)
                                .stroke(Color("Green2"), lineWidth: 1)
                                .frame(height: 50)
                                .animation(.easeInOut(duration: 0.8), value: cityFocused)
                            
                            
                        }
                    )
                    .padding(.horizontal)

                
                // Country
                HStack {
                    Text("Country:")
                    
                    TextField(holiday.location.country, text: $newCountry)
                        .focused($countryFocused)
                        .multilineTextAlignment(.leading)

                }
                    .padding()
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .foregroundColor(.white)
                                .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                                .frame(height: 50)
                            
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .trim(from: 0, to: countryFocused ? 1 : 0)
                                .stroke(Color("Green2"), lineWidth: 1)
                                .frame(height: 50)
                                .animation(.easeInOut(duration: 0.8), value: countryFocused)
                            
                            
                        }
                    )
                    .padding(.horizontal)

                
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
                        .padding(.leading)
                    
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
                
            }
            
            
            
            Spacer()
        
        }
        .foregroundColor(Color("Green1"))
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $newThumbnail)
        }

        
    }
}

//struct EditHolidayView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditHolidayView()
//    }
//}
