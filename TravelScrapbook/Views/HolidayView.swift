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
    
    let columns = [
        GridItem(.adaptive(minimum: 110), spacing: 5)
        ]

    
    @State private var selectedImage: UIImage?
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            //MARK: Header Image
            ZStack {
                
                if holiday.mainImage == nil {
                    ZStack {
                        RoundedCorner(radius: 20, corners: [.bottomLeft, .bottomRight])
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
                            .clipped()

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
            .frame(height: 280)
            .clipShape(
//                RoundedRectangle(cornerRadius: 20, style: .continuous)
                RoundedCorner(radius: 20, corners: [.bottomLeft, .bottomRight])
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
                                    selectedImage = image
                                    showImage = true

                            } label: {

                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 110, height: 110)
                                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                            }

//

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
        .fullScreenCover(isPresented: $showImage) { [selectedImage] in
            ImageView(image: selectedImage ?? UIImage(systemName: "photo.fill")!)
        }
        
        
    }
}

struct HolidayView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        HolidayView(holiday: Holiday(title: "Prague with the guys!", date: Date.now, location: Location(city: "Prague", country: "Czech", coordinates: CLLocationCoordinate2D.init(latitude: 0, longitude: 0))))
    }
}
