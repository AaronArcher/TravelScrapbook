//
//  ImageHelper.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 28/07/2022.
//

import Foundation
import SwiftUI

class ImageHelper {
    
    static func compressImage(image: UIImage) -> UIImage {
        
        let resizedImage = image.aspectFittedToHeight(200)
//        resizedImage.jpegData(compressionQuality: 0.2)
        
        return resizedImage
        
    }
    
}
