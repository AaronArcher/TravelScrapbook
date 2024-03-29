//
//  RoundedCornerShape.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 20/07/2022.
//

import Foundation
import SwiftUI

extension View {
    func clippedCornerShape(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCornerShape(radius: radius, corners: corners) )
    }
}

struct RoundedCornerShape: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
    
}
