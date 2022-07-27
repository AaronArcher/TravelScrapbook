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
                    
            Button {
                

                showHoliday = true
                
            } label: {

                MainHolidayImage(holiday: holiday, iconSize: 35)
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .padding(2)
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

//struct MapAnnotationView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapAnnotationView()
//    }
//}
