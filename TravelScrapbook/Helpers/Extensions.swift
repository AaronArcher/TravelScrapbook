//
//  Extensions.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 23/06/2022.
//

import Foundation
import SwiftUI

extension Image {

    public init(data: Data?, placeholder: String) {
        guard let data = data,
          let uiImage = UIImage(data: data) else {
            self = Image(placeholder)
            return
        }
        self = Image(uiImage: uiImage)
    }
}

// https://designcode.io/swiftui-advanced-handbook-compress-a-uiimage
extension UIImage {
    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
        
    }
}


