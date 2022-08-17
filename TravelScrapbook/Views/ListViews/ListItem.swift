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
            
            if holiday.isWishlist {
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .frame(width: 90, height: 90)
                
            } else {
                MainHolidayImage(holiday: holiday, iconSize: 50)
                    .frame(width: 90, height: 90)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .padding(.trailing)
            }
            
            
            VStack(alignment: .leading) {
                
                Text(holiday.title)
                    .foregroundColor(Color("Green2"))
                    .bold()
                
//                Spacer()
                                
                HStack(spacing: 5) {
                    Text("\(holiday.location.city),")
                    Text(holiday.location.country)
                        .italic()
                    
                    Spacer()
                }
                .font(.footnote)
                            
                Text(holiday.date!.formatted(date: .numeric, time: .omitted))
                    .font(.footnote)

                
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
