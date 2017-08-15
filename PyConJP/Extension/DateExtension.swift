//
//  DateExtension.swift
//  PyConJP
//
//  Created by Yutaro Muta on 7/18/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import Foundation

extension Date {
    
    static func date(from string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: string)
    }
    
    var components: DateComponents {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.dateComponents([.year, .month, .day, .weekday, .hour, .minute], from: self)
    }
    
    var hourClock: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h\na"
        return dateFormatter.string(from: self)
    }
    
    func convertToTime() -> String {
        let components = self.components
        return String(format: "%02d", components.hour!) + ":" + String(format: "%02d", components.minute!)
    }
    
    func calculate(year: Int = 0, month: Int = 0, day: Int = 0, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date? {
        
        var components = self.components
        components.year = (components.year ?? 0) + year
        components.month = (components.month ?? 0) + month
        components.day = (components.day ?? 0) + day
        components.hour = (components.hour ?? 0) + hour
        components.minute = (components.minute ?? 0) + minute
        components.second = (components.second ?? 0) + second
        
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.date(from: components)
        
    }
    
    func update(year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil) -> Date? {
        
        var components = self.components
        components.year = year ?? components.year
        components.month = month ?? components.month
        components.day = day ?? components.day
        components.hour = hour ?? components.hour
        components.minute = minute ?? components.minute
        components.second = second ?? components.second
        
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.date(from: components)
        
    }
    
}
