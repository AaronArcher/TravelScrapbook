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
            
//            Color("Background")
            
            if holidayvm.visited.count == 0 && holidayvm.wishlist.count == 0 {
                
                Text("You haven't created any holidays yet!")
                    .font(.title2)
                    .foregroundColor(Color("Text"))
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
                            .listRowBackground(Color("Background"))
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
                            .listRowBackground(Color("Background"))
                            .sheet(isPresented: $showHoliday) {
                                EditHolidayView(holiday: holiday, newDate: Date())
                            }
                        }
                        .listRowSeparatorTint(Color("Text"))
                        .listStyle(.plain)
                        .padding(.vertical)
                    }
                }
            }
        }
        .ignoresSafeArea()
        .background(Color("Background"))
        
    }
    
    @ViewBuilder
    var segmentBar: some View {
        let options = ["Visited", "Wishlist"]
        
        HStack(spacing: 10) {
                        
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
                        .foregroundColor(Color("PrimaryGreen"))
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
                        
        }
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .foregroundColor(Color("SliderBackground"))
        )
        
    }
    
}

//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListView()
//    }
//}
