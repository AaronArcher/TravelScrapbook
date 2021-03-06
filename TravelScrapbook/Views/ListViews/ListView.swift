//
//  ListView.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 23/06/2022.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var holidayvm: HolidayViewModel

    @Binding var showHoliday: Bool
    
    @Namespace var namespace
    
    var body: some View {
            
        ZStack {
            
            Color(.white)
            
            if holidayvm.allHolidays.count == 0 {
                
                Text("You haven't created any holidays yet!")
                    .font(.title2)
                    .foregroundColor(Color("Green1"))
                    .multilineTextAlignment(.center)
                    .padding()
                
            } else {
                
                switch holidayvm.selectedCategory {
                    
                case .all:
                    List((holidayvm.visited + holidayvm.wishlist)) { holiday in
                        
                        Button {
                            showHoliday = true
                        } label: {
                            ListItem(holiday: holiday)
                                    .padding(.vertical, 5)
                        }
                        .fullScreenCover(isPresented: $showHoliday) {
                            HolidayView(holiday: holiday)
                        }
                            
                        }
                        .listRowSeparatorTint(Color("Green1"))
                        .listStyle(.plain)
                        .padding(.vertical)
                        
                    
                case .visited:
                    List(holidayvm.visited) { holiday in
                        
                        Button {
                            showHoliday = true
                        } label: {
                            ListItem(holiday: holiday)
                                    .padding(.vertical, 5)
                        }
                        .fullScreenCover(isPresented: $showHoliday) {
                            HolidayView(holiday: holiday)
                        }
                            
                        }
                        .listRowSeparatorTint(Color("Green1"))
                        .listStyle(.plain)
                        .padding(.vertical)
                        
                    
                case .wishlist:
                    List(holidayvm.wishlist) { holiday in
                        
                        Button {
                            showHoliday = true
                        } label: {
                            ListItem(holiday: holiday)
                                    .padding(.vertical, 5)
                        }
                        .fullScreenCover(isPresented: $showHoliday) {
                            HolidayView(holiday: holiday)
                        }
                            
                        }
                        .listRowSeparatorTint(Color("Green1"))
                        .listStyle(.plain)
                        .padding(.vertical)
                        
                    
                }
                
                List((holidayvm.visited + holidayvm.wishlist)) { holiday in
                    
                    Button {
                        showHoliday = true
                    } label: {
                        ListItem(holiday: holiday)
                                .padding(.vertical, 5)
                    }
                    .fullScreenCover(isPresented: $showHoliday) {
                        HolidayView(holiday: holiday)
                    }
                        
                    }
                    .listRowSeparatorTint(Color("Green1"))
                    .listStyle(.plain)
                    .padding(.vertical)
                    
                    
            }
            
        }
        .ignoresSafeArea()
            
        
    }
    
    
}

//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListView(showHoliday: .constant(false))
//    }
//}
