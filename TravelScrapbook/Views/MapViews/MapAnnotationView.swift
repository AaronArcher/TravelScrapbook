//
//  MapAnnotationView.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 18/06/2022.
//

import SwiftUI
import MapKit

struct MapAnnotationView: View {
    
    let holiday: Holiday
        
    @State private var showHoliday = false
    
    
    var body: some View {
        
        if holiday.isWishlist {
            
            Button {

                
            } label: {

                ZStack {
                
                    Image(systemName: "heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                    
                    Image(systemName: "heart.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 27, height: 27)
                        .foregroundColor(Color("Green1"))
                    
                }

            }
            
        } else {
            
            Button {

                showHoliday = true
                
            } label: {

                MainHolidayImage(holiday: holiday, iconSize: 35)
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .padding(1)
                    .mask({
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                    })
                    .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .foregroundColor(.white)
                            
                    )
                    .fullScreenCover(isPresented: $showHoliday) {
                        HolidayView(holiday: holiday)
                    }

            }
        }
        
            
    }
}

//struct MapAnnotationView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapAnnotationView()
//    }
//}
