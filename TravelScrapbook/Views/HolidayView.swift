//
//  HolidayView.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 26/06/2022.
//

import SwiftUI

struct HolidayView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            
            Button {
                dismiss()
            } label: {
                Text("Close")
            }

            
        }
    }
}

struct HolidayView_Previews: PreviewProvider {
    static var previews: some View {
        HolidayView()
    }
}
