//
//  Formatting.swift
//  FetchRewards
//
//  Created by James Sedlacek on 5/22/21.
//

import Foundation

struct Formatting {
    
    // MARK: - Date
    
    /// <#Description#>
    /// - Parameter dateTime: <#dateTime description#>
    /// - Returns: <#description#>
    public static func formatDate(from dateTime: String) throws -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        guard let safeDate = dateFormatterGet.date(from: dateTime)
        else { throw K.ValidationError.invalidDateTime }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMM yyyy" //Example: Wednesday, 19 May 2021
        return dateFormatter.string(from: safeDate)
    }
    
    // MARK: - Time
    
    /// <#Description#>
    /// - Parameter dateTime: <#dateTime description#>
    /// - Returns: <#description#>
    public static func formatTime(from dateTime: String) throws -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        guard let safeDate = dateFormatterGet.date(from: dateTime)
        else { throw K.ValidationError.invalidDateTime }
        
        let timeFormatter = DateFormatter()
        timeFormatter.locale = Locale(identifier: "en_US_POSIX")
        timeFormatter.dateFormat = "hh:mm a" //Example: 01:15 PM
        timeFormatter.amSymbol = "AM"
        timeFormatter.pmSymbol = "PM"
        return timeFormatter.string(from: safeDate)
        
    }
}
