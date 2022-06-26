//
//  ListView.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 23/06/2022.
//

import SwiftUI

struct ListView: View {
    
//    @EnvironmentObject var holidayvm: HolidayViewModel

    @Binding var showHoliday: Bool
    
    var body: some View {
            
        ZStack {
            
            Color(.white)
            
            List(0..<10) { i in
                    listItem
                        .padding(.vertical, 5)
                        .onTapGesture {
                            showHoliday = true
                        }
                }
                .listRowSeparatorTint(Color("Green1"))
                .listStyle(.plain)
                .padding(.vertical)
            
        }
        .ignoresSafeArea()
            
        
    }
    
    var listItem: some View {
        HStack {
            
            Image("Panda")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .padding(.trailing)
            
            VStack(alignment: .leading) {
                
                Text("Holiday title")
                    .font(.title2)
                    .foregroundColor(Color("Green1"))
                    .bold()
                    .padding(.bottom, 5)
                
                Text("13/03/2020")
                
                HStack {
                    Text("City,")
                    Text("Country")
                        .font(.callout)
                        .italic()
                }
                
                Text("With: Fiona")
                
                
            }
            .foregroundColor(Color("Green2"))
            
            Spacer()
        }
    }
    
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(showHoliday: .constant(false))
    }
}
