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
    @Binding var showHoliday: Bool

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
                RoundedCornerShape(radius: 20, corners: [.bottomLeft, .bottomRight])
            )
            
            ScrollView {
            
                VStack(alignment: .leading) {
                    
                    
                    HStack {
                        
                        Text("City:")
                            .bold()
                        
                        Text(holiday.location.city)
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .background(
                        TextBackground(isTextfield: false)
                    )
                    .padding(.vertical, 10)
                    
                    
                    HStack {
                        
                        Text("Country:")
                            .bold()
                        
                        Text(holiday.location.country)
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .background(
                        TextBackground(isTextfield: false)
                    )
                    .padding(.vertical, 10)
                    
                    HStack {
                        
                        Text("Date Visited:")
                            .bold()
                        
                        Text(DateHelper.formatDate(date: holiday.date))
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .background(
                        TextBackground(isTextfield: false)
                    )
                    .padding(.vertical, 10)
                    
                    HStack {
                        
                        Text("Visited with:")
                            .bold()
                        
                            
                        Text(holiday.visitedWith ?? "")
                        
                        
                        
                        Spacer()
                        
                        
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .background(
                        TextBackground(isTextfield: false)
                    )
                    .padding(.vertical, 10)
                    .padding(.bottom, 10)

                    
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
                            .padding(.horizontal, 35)
                            .background(
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .foregroundColor(.red)
                            )
                            .frame(maxWidth: .infinity)
                    
                }
                
                Spacer()
            
            }

            
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
//                        print("deletion successful")
                        DispatchQueue.main.async {
                            dismiss()
                        }
                        showHoliday = false
                        
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
