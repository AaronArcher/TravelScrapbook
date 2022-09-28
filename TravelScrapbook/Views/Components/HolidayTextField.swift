//
//  HolidayTextField.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 22/09/2022.
//

import SwiftUI

struct HolidayTextField: View {
    
    let placeholderText: String
    @Binding var text: String
    @FocusState.Binding var isFocused: Bool
    
    var body: some View {

        VStack(spacing: 0) {
            TextField(placeholderText, text: $text)
                .padding(.vertical, 5)
                .focused($isFocused)
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.gray.opacity(0.5))
                    .cornerRadius(5)
                
                Rectangle()
                    .frame(height: 2)
                    .frame(maxWidth: isFocused || !text.isEmpty ? .infinity : 0)
                    .animation(.easeInOut, value: isFocused)
                    .foregroundColor(Color("Green1"))
                    .cornerRadius(5)
            }
            .padding(.trailing)
        }

    }
}

//struct HolidayTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        HolidayTextField()
//    }
//}
