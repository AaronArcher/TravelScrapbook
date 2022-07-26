//
//  DateHelper.swift
//  TravelScrapbook
//
//  Created by Aaron Johncock on 25/07/2022.
//

import Foundation

class DateHelper {
    
    static func formatDate(date: Date?) -> String {

        guard date != nil else { return "" }

        let df = DateFormatter()
        df.dateFormat = "d MMM, yyyy"
        
        return df.string(from: date!)
        
    }
    
}
