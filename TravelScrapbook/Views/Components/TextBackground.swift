//
//  TextFieldBackground.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 21/08/2022.
//

import Foundation
import SwiftUI

struct TextBackground: View {
    
    let isTextfield: Bool
    var smallHeight: Bool = false
    var isFocused: Bool = false
    
    var body: some View {
        
        if isTextfield {
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .foregroundColor(Color("TextBackground"))
                    .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                    .frame(minHeight: smallHeight ? 35 : 45)
                
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .trim(from: 0, to: isFocused ? 1 : 0)
                    .stroke(Color("Green2"), lineWidth: 1)
                    .frame(minHeight: smallHeight ? 35 : 45)
                    .animation(.easeInOut(duration: 0.8), value: isFocused)
                
            }
            
        } else {
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .foregroundColor(Color("TextBackground"))
                .shadow(color: Color("Green2").opacity(0.15), radius: 15, x: 4, y: 4)
                .frame(minHeight: smallHeight ? 35 : 45)

        }
        
        
    }
    
}
