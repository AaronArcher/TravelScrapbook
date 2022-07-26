//
//  MapAnnotationView.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 18/06/2022.
//

import SwiftUI
import MapKit

struct MapAnnotationView: View {
    
    @State private var isTapped = false
    let holiday: Holiday
    @Namespace private var namespace
    
    @Binding var region: MKCoordinateRegion
    
    
    var body: some View {
        
        Group {
        
            if isTapped {
            VStack(alignment: .leading) {
                
                Text(holiday.title)
                    .bold()
                
                Text(DateHelper.formatDate(date: holiday.date))
                    .italic()
                
                Text(holiday.location.city)
                Text(holiday.location.country)
                    .font(.footnote)
                
                Button {
                    withAnimation {
                        isTapped.toggle()
                    }
                } label: {
                    
                    Image(uiImage: holiday.mainImage ?? UIImage(named: "Panda")!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .matchedGeometryEffect(id: "pic", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                }
                
            }
            .padding()
            .mask({
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .matchedGeometryEffect(id: "mask", in: namespace)
            })
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .foregroundColor(.white)
                    .matchedGeometryEffect(id: "bg", in: namespace)
            )
            .frame(minWidth: 150)
            
            
        } else {
            
            Button {
                withAnimation {
                    isTapped.toggle()
                }
            } label: {
//                VStack(spacing: 0) {
                Image(uiImage: holiday.mainImage ?? UIImage(named: "Panda")!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .matchedGeometryEffect(id: "pic", in: namespace)
                    .padding(2)
                    .mask({
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .matchedGeometryEffect(id: "mask", in: namespace)
                    })
                    .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .foregroundColor(.white)
                                .matchedGeometryEffect(id: "bg", in: namespace)
                            
                    )
                    
//                    Image(systemName: "arrowtriangle.down.fill")
//                        .resizable()
////                        .scaledToFit()
//                        .frame(width: 15, height: 6)
//                        .foregroundColor(.white)
//                        .opacity(isTapped ? 0 : 1)
//            }
                
            }
            .frame(minWidth: 150)
            
            
        }
        
        }
        
    }
}

//struct MapAnnotationView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapAnnotationView()
//    }
//}
