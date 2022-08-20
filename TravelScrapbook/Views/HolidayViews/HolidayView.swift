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

    @State private var showDelete = false
    @State private var showEditHoliday = false

    
    var body: some View {
                
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
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.white)
                                .frame(width: 35, height: 35)
                                .shadow(color: Color("Green1").opacity(0.15), radius: 15, x: 4, y: 4)
                            
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                .foregroundColor(Color("Green1"))
                        }
                            
                        
                    }
                        
                        Spacer()

                        Button {
                            
                            showEditHoliday = true
                        
                        } label: {
                            
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.white)
                                    .frame(width: 35, height: 35)
                                    .shadow(color: Color("Green1").opacity(0.15), radius: 15, x: 4, y: 4)
                                
                                Image(systemName: "square.and.pencil")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color("Green1"))
                                    
                            }
                            
                        }
                                            
                    
                }
                    .padding()
                    .frame(maxHeight: .infinity, alignment: .top)
                    

                                    
                    VStack {
                        HStack {
                            Text(holiday.title)
                                    .font(.title)
                                    .foregroundColor(.white)
                            
                            Spacer()
                        }

                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
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
            
            
                VStack(alignment: .leading, spacing: 15) {
                    
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
                    .padding(.vertical)

                    
                }
                .padding(.horizontal)
                .padding(.top, 10)
            
                Spacer()
                                    
                    // Delete Button
                    Button {
                       
                       showDelete = true
                        
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
        .sheet(isPresented: $showEditHoliday, content: {
            EditHolidayView(holiday: holiday, newDate: holiday.date ?? Date())
        })
        .alert("Are you sure you want to delete this destination?", isPresented: $showDelete) {
            Button {
                // Delete holiday
                DatabaseService().deleteHoliday(holiday: holiday) { success, error in
                    if success {
                        
                        DispatchQueue.main.async {
                            dismiss()
                        }
                        
                    } else {
                        // TODO: handle error
                        
                    }
                }
            } label: {
                Text("Yes")
            }
            
            Button("Cancel", role: .cancel) { }

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
