//
//  ListView.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 23/06/2022.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var holidayvm: HolidayViewModel
    
    @State var showHoliday = false
    @Namespace private var namespace
    
    @State private var category = "Visited"
    
    
    var body: some View {
        
        ZStack {
            
            Color(.white)
            
            if holidayvm.visited.count == 0 && holidayvm.wishlist.count == 0 {
                
                Text("You haven't created any holidays yet!")
                    .font(.title2)
                    .foregroundColor(Color("Green1"))
                    .multilineTextAlignment(.center)
                    .padding()
                
            } else {
                
                VStack(spacing: 5) {
                    
                    segmentBar
                        .padding(.top)
                    
                    if category == "Visited" {
                        List(holidayvm.visited.sorted()) { holiday in
                            
                            Button {
                                showHoliday = true
                            } label: {
                                ListItem(holiday: holiday)
                                    .padding(.vertical, 5)
                            }
                            .sheet(isPresented: $showHoliday) {
                                HolidayView(holiday: holiday, showHoliday: $showHoliday)
                            }
                        }
                        .listRowSeparatorTint(Color("Green1"))
                        .listStyle(.plain)
                        .padding(.vertical)
                    } else {
                        List(holidayvm.wishlist.sorted()) { holiday in
                            
                            Button {
                                showHoliday = true
                            } label: {
                                ListItem(holiday: holiday)
                                    .padding(.vertical, 5)
                            }
                            .sheet(isPresented: $showHoliday) {
                                EditHolidayView(holiday: holiday, newDate: Date())
                            }
                        }
                        .listRowSeparatorTint(Color("Green1"))
                        .listStyle(.plain)
                        .padding(.vertical)
                    }
                }
            }
        }
        .ignoresSafeArea()
        
    }
    
    @ViewBuilder
    var segmentBar: some View {
        let options = ["Visited", "Wish List"]
        
        HStack(spacing: 15) {
            
            Spacer()
            
            ForEach(options, id: \.self) { tab in
                
                if category == tab {
                    Text(tab)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color("Green1"))
                                .matchedGeometryEffect(id: "tab", in: namespace)
                        )
                } else {
                    Text(tab)
                        .foregroundColor(Color("Green1"))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.clear)
                        )
                        .onTapGesture {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                category = tab
                            }
                        }
                }
                
            }
            
            Spacer()
            
        }
        
    }
    
}

//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListView()
//    }
//}
