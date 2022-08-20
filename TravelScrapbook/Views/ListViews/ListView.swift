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
                
                List(holidayvm.visited) { holiday in
                    
                    Button {
                        showHoliday = true
                    } label: {
                        ListItem(holiday: holiday)
                                .padding(.vertical, 5)
                    }
                    .sheet(isPresented: $showHoliday) {
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
