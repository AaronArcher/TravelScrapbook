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
          
            GeometryReader { geo in
                ZStack {
                    
                    MainHolidayImage(holiday: holiday, iconSize: 100)

                    
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
    
//                            Text(holiday.date.formatted(date: .numeric, time: .omitted))
//                                .italic()
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
                
            }
            .frame(height: 280)
            .clipShape(
                RoundedCorner(radius: 20, corners: [.bottomLeft, .bottomRight])
            )
            
            
            Spacer()

            
        }
        .foregroundColor(Color("Green1"))
        .ignoresSafeArea(edges: .top)
        .fullScreenCover(isPresented: $showImage) { [selectedImage] in
            ImageView(image: selectedImage ?? UIImage(systemName: "photo.fill")!)
        }
        
        
    }
}

//struct HolidayView_Previews: PreviewProvider {
//    
//    
//    static var previews: some View {
//        HolidayView(holiday: Holiday(createdBy: "", title: "Prague with the guys!", date: Date.now, location: Location(city: "Prague", country: "Czech", coordinates: CLLocationCoordinate2D.init(latitude: 0, longitude: 0))))
//    }
//}
