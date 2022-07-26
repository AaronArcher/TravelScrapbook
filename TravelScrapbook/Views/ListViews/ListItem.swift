//
//  ListItem.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 30/06/2022.
//

import SwiftUI
import MapKit


struct ListItem: View {
    
    var holiday: Holiday

    var body: some View {

        HStack {
            
            ZStack {

                if holiday.mainImage != nil {
                    Image(uiImage: holiday.mainImage!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 90, height: 90)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                } else {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .foregroundColor(Color("Green1").opacity(0.2))
                        .frame(width: 90, height: 90)
                    
                    Image(systemName: "photo.fill")
                        .font(.title)
                        .foregroundColor(Color("Green2"))
                }
                                
            }
            .padding(.trailing)
            
            
            VStack(alignment: .leading) {
                
                Text(holiday.title)
                    .font(.title3)
                    .foregroundColor(Color("Green2"))
                    .bold()
                
                Spacer()
                
                Text(holiday.date.formatted(date: .numeric, time: .omitted))
                
                HStack {
                    Text(holiday.location.city)
                    Text(holiday.location.country)
                        .font(.callout)
                        .italic()
                }
                                
                
            }
            .padding(.vertical)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.largeTitle)
                .padding(.trailing)
        }
        .foregroundColor(Color("Green1"))

    }
}

//struct ListItem_Previews: PreviewProvider {
//    static var previews: some View {
//        ListItem(holiday: Holiday(createdBy: "", title: "Prague with the guys!", date: Date.now, location: Location(city: "Prague", country: "Czech", coordinates: CLLocationCoordinate2D.init(latitude: 0, longitude: 0))))
//    }
//}
