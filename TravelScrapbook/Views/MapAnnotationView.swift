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
    
    var body: some View {
                    
            if isTapped {
                VStack(alignment: .leading) {
                                        
                    Text(holiday.name)
                        .bold()
                    
                    Text(holiday.date.formatted(date: .abbreviated, time: .omitted))
                        .italic()
                    
                    Text(holiday.location.city)
                    Text(holiday.location.country)
                        .font(.footnote)
                    
                    Button {
                        DispatchQueue.main.async {
                            withAnimation {
                                isTapped.toggle()
                            }
                        }
                    } label: {
                        Image("Panda")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .matchedGeometryEffect(id: "pic", in: namespace)
                            .frame(maxWidth: .infinity, alignment: .center)

                    }
                    
                }
                .padding()
                .mask({
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .matchedGeometryEffect(id: "mask", in: namespace)
                })
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .foregroundColor(.white)
                        .matchedGeometryEffect(id: "bg", in: namespace)
                )
                .frame(minWidth: 150)
                

            } else {
                
                Button {
                    DispatchQueue.main.async {
                        withAnimation {
                            isTapped.toggle()
                        }
                    }
                } label: {
                    Image("Panda")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .matchedGeometryEffect(id: "pic", in: namespace)
                        .mask({
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .matchedGeometryEffect(id: "mask", in: namespace)
                        })
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .foregroundColor(.white)
                                .matchedGeometryEffect(id: "bg", in: namespace)
                        )
                }
                .frame(minWidth: 150)

            }

                
    }
}

//struct MapAnnotationView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapAnnotationView()
//    }
//}
