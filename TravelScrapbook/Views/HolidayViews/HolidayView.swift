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
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            //MARK: Header Image
          
            GeometryReader { geo in
                ZStack {
                    
                    MainHolidayImage(holiday: holiday, iconSize: 100)
                        .frame(width: geo.size.width, height: 300)

                    
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
                                    .font(.title)
                                    .foregroundColor(.white)
                            
                            Spacer()
                        }

                    }
                    .padding()
                    .background(
                        Color("Green1").opacity(0.5)
                            .background(.ultraThinMaterial)
                    )
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
                
            }
            .frame(height: 300)
            .clipShape(
                RoundedCorner(radius: 20, corners: [.bottomLeft, .bottomRight])
            )
            
            
            VStack(alignment: .leading, spacing: 12) {
                
                HStack {
                    
                    Text("City:")
                        .bold()
                    
                    Text(holiday.location.city)
                    
                    Spacer()
                    
                }
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .foregroundColor(.white)
                        .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                        .frame(height: 50)
                )
                .padding(.vertical)
                
                
                HStack {
                    
                    Text("Country:")
                        .bold()
                    
                    Text(holiday.location.country)
                    
                    Spacer()
                    
                }
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .foregroundColor(.white)
                        .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                        .frame(height: 50)
                )
                .padding(.vertical)
                
                HStack {
                    
                    Text("Date Visited:")
                        .bold()
                    
                    Text(DateHelper.formatDate(date: holiday.date))
                    
                    Spacer()
                    
                }
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .foregroundColor(.white)
                        .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                        .frame(height: 50)
                )
                .padding(.vertical)
                
                HStack {
                    
                    Text("Visited with:")
                        .bold()
                    
                    Text("Fiona")
                    
                    Spacer()
                    
                }
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .foregroundColor(.white)
                        .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                        .frame(height: 50)
                )
                .padding(.vertical)

                
            }
            .padding(.horizontal)
            .padding(.top, 20)
          
        
            Spacer()

            Button {
                // TODO: Delete holiday
                
            } label: {
                
                    Text("Delete")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                        .background(
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .foregroundColor(.red)
                        )
                
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.bottom, 20)

            
        }
        .foregroundColor(Color("Green1"))
        .ignoresSafeArea(edges: .top)
        
        
    }
}

//struct HolidayView_Previews: PreviewProvider {
//
//
//    static var previews: some View {
//        HolidayView(holiday: Holiday()
//    }
//}
