//
//  HolidayView.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 26/06/2022.
//

import SwiftUI
import MapKit

struct HolidayView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var holiday: Holiday
    
    @State private var showImage = false
    
//    let columns = [
//        GridItem(.adaptive(minimum: 150))
//        ]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
        ]
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            //MARK: Header Image
            ZStack {
                
                if holiday.mainImage == nil {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color("Green1").opacity(0.2))
                        
                        Image(systemName: "photo.fill")
                            .font(.title)
                            .foregroundColor(Color("Green2"))
                    }
                    
                } else {
                    ZStack {
                        
                        Image(uiImage: holiday.mainImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 300)
//
                    }
                }
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(Color("Green1"))
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.white)
                                .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                        )
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                .padding(.top, 15)
                
                VStack {
                    HStack {
                        Text(holiday.title)
                            .font(.title2)
                            .foregroundColor(Color("Green2"))
                        
                        Spacer()
                        
                        Text(holiday.date.formatted(date: .numeric, time: .omitted))
                            .italic()
                    }
                    
                    HStack {
                        Text(holiday.location.city)
                        
                        Text(holiday.location.country)
                            .italic()
                        Spacer()
                    }
                    
                }
                .padding()
                .background(
                    .ultraThinMaterial
                )
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .frame(height: 300)
            .clipShape(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
            )
            
            Text("All Photos")
                .font(.title)
                .padding(.horizontal)
                .padding(.top, 10)
            
                
                if holiday.allImages.count == 0 {
                    Text("You haven't added any photos yet!")
                        .font(.title3)
                        .foregroundColor(Color("Green2"))
                        .multilineTextAlignment(.center)
               
                } else {

                    ScrollView {

                        LazyVGrid(columns: columns, spacing: 5) {
                        ForEach(holiday.allImages, id: \.self) { image in
                    
                            Button {
                                showImage = true
                            } label: {
                               
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                
                            }
                            .fullScreenCover(isPresented: $showImage) {
                                ImageView(image: image)
                            }
                           

                            
                        }
                    }
                        .padding(.bottom, 30)
                        
                }
                .padding(.horizontal)
                }
    
            
            
            Spacer()

            
        }
        .foregroundColor(Color("Green1"))
        .ignoresSafeArea()
    }
}

struct HolidayView_Previews: PreviewProvider {
    static var previews: some View {
        HolidayView(holiday: Holiday(title: "Prague with the guys!", date: Date.now, location: Location(city: "Prague", country: "Czech", coordinates: CLLocationCoordinate2D.init(latitude: 0, longitude: 0))))
    }
}
