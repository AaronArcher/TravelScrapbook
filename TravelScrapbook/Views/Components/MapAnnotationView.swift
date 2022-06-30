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
                    
            if isTapped {
                VStack(alignment: .leading) {
                                        
                    Text(holiday.title)
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
                        
                        Image(uiImage: holiday.mainImage ?? UIImage(named: "Panda")!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .matchedGeometryEffect(id: "pic", in: namespace)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                    }
                    
                }
                .padding()
                .mask({
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .matchedGeometryEffect(id: "mask", in: namespace)
                })
                .background(
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
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
                    ZStack {
                        Image(uiImage: holiday.mainImage ?? UIImage(named: "Panda")!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                        
                        Circle()
                            .stroke(.white, lineWidth: 3)
                            
                    }
                    .frame(width: 50, height: 50)
                    .matchedGeometryEffect(id: "pic", in: namespace)
                    .mask({
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .matchedGeometryEffect(id: "mask", in: namespace)
                    })
                    .background(
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
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
