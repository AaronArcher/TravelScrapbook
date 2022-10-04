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
                    .foregroundColor(Color("Pink1"))
                    .frame(width: 40, height: 40)
                    .padding(.trailing)
                
            } else {
                MainHolidayImage(holiday: holiday, iconSize: 40)
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .padding(.trailing)
            }
            
            VStack(alignment: .leading) {
                
                Text(holiday.title)
                    .bold()
                                      
                if holiday.location.city != "" && holiday.location.country != "" {
                    HStack(spacing: 10) {
                        Text(holiday.location.city)
                        Text(holiday.location.country)
                            .italic()
                        
                        Spacer()
                    }
                    .font(.footnote)
                }
                            
                if !holiday.isWishlist {
                    Text(holiday.date!.formatted(date: .numeric, time: .omitted))
                        .font(.footnote)
                }
                
            }
            .padding(.vertical)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.largeTitle.weight(.ultraLight))
                .padding(.trailing, 10)
        }
        .foregroundColor(Color("PrimaryGreen"))
        .background(Color("Background"))

        
    }
}

//struct ListItem_Previews: PreviewProvider {
//    static var previews: some View {
//        ListItem(holiday: Holiday(createdBy: "", title: "Prague with the guys!", date: Date.now, location: Location(city: "Prague", country: "Czech", coordinates: CLLocationCoordinate2D.init(latitude: 0, longitude: 0))))
//    }
//}
