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
