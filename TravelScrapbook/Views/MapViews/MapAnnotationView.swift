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
    
    var span: Double
    
    @Namespace var namespace
    
    @State private var showWishlist = false
    @State private var showEditWishlist = false
    
    
    var body: some View {
        
        if span > 50 {
            
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 10, height: 10)
                Circle()
                    .foregroundColor(holiday.isWishlist ? Color("Pink1") : Color("Green1"))
                    .frame(width: 8, height: 8)
            }
            
        } else {
        
            if holiday.isWishlist {
                
                VStack(spacing: 2) {
                    
                    Button {

                        withAnimation {
                            showWishlist.toggle()
                        }
                        
                    } label: {

                        ZStack {
                        
                            Image(systemName: "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 33, height: 33)
                                .foregroundColor(.white)
                            
                            Image(systemName: "heart.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color("Pink1"))
                            
                        }
                    }
                    
                    if showWishlist {
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .foregroundColor(.white)
                                .frame(width: 150, height: 70)
                            
                            VStack(spacing: 0) {
                                
                                Spacer()
                                
                                Text(holiday.title)
                                    .foregroundColor(Color("Green1"))
                                    .font(.subheadline)
                                
                                Spacer()
                                
                                HStack(spacing: 0) {
                                    
                                    Button {
                                        
                                    } label: {
                                        
                                        ZStack {
                                            
                                            Rectangle()
                                                .fill(.red)
                                                .frame(height: 35)
                                                               
                                                Text("DELETE")
                                                    .font(.footnote)
                                                    .foregroundColor(.white)
                                                
                                        }
                                    }
                                                                        
                                    Button {
                                        
                                        showEditWishlist = true
                                        
                                    } label: {
                                        
                                        ZStack {
                                            
                                            Rectangle()
                                                .fill(Color("Green1"))
                                                .frame(height: 35)
                                                                                            
                                                Text("EDIT")
                                                    .font(.footnote)
                                                    .foregroundColor(.white)

                                                
                                                
                                        }
                                    }
                                    
                                }
                                
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .shadow(color: Color("Green2").opacity(0.3), radius: 15, x: 5, y: 5)
                        .transition(.scale)
                        .sheet(isPresented: $showEditWishlist) {
                            EditHolidayView(holiday: holiday, newDate: Date())
                        }
                        
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
}

//struct MapAnnotationView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapAnnotationView()
//    }
//}
