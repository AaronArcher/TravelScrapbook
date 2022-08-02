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
        
        NavigationView {
        
        VStack(alignment: .leading) {
            
            //MARK: Header Image
            GeometryReader { geo in
                ZStack {
                    
                    MainHolidayImage(holiday: holiday, iconSize: 100)
                        .frame(width: geo.size.width, height: 300)

                    
                    HStack {
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .foregroundColor(Color("Green1"))
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.white)
                                    .frame(width: 37, height: 37)
                                    .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                            )
                        
                    }
                        
                        Spacer()

                        NavigationLink {
                            
                            EditHolidayView(holiday: holiday, newDate: holiday.date ?? Date())
                        
                        } label: {
                            
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 23, height: 23)
                                .foregroundColor(Color("Green1"))
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.white)
                                        .frame(width: 37, height: 37)
                                        .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                                )
                            
                        }
                                            
                    
                }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(25)
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
                        
                            
                        Text(holiday.visitedWith ?? "")
                        
                        
                        
                        Spacer()
                        
                        
                    }
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .foregroundColor(.white)
                            .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                            .frame(height: 50)
                    )
                    .padding(.vertical, 20)

                    
                }
                .padding(.horizontal)
                .padding(.top, 20)
                .padding(.bottom, 10)
            
        

                                    
                    // Delete Button
                    Button {
                       
                        // Delete holiday
                        DatabaseService().deleteHoliday(holiday: holiday) { success, error in
                            if success {
                                
                                DispatchQueue.main.async {
                                    dismiss()
                                }
                                
                            } else {
                                // handle error
                                
                            }
                        }
                        
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
                            .frame(maxWidth: .infinity)
                    
                }
                    
                 
            
            Spacer()

            
        }
        .foregroundColor(Color("Green1"))
        .ignoresSafeArea(edges: .top)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        }
        
    }
}

//struct HolidayView_Previews: PreviewProvider {
//
//
//    static var previews: some View {
//        HolidayView(holiday: Holiday()
//    }
//}
