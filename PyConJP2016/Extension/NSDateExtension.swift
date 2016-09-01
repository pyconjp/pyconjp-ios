//
//  NSDateExtension.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 7/18/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

extension NSDate {
    
    static func dateFromString(string: String) -> NSDate? {
        
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: NSDateFormatter! = nil
        }
        
        dispatch_once(&Static.onceToken) { 
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            Static.instance = formatter
        }
        
        return Static.instance.dateFromString(string)
    }
    
    func convertToTime() -> String {
        let calender = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let components = calender.components([.Year, .Month, .Day, .Weekday, .Hour, .Minute], fromDate: self)
        return String(format: "%02d", components.hour) + ":" + String(format: "%02d", components.minute)
    }
    
}
