//
//  NSDateExtension.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 7/18/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

extension NSDate {
    
    static func dateFromString(dateString: String) -> NSDate? {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.dateFromString(dateString)
    }
    
    static func timeFromDate(date: NSDate) -> String {
        let calender = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let components = calender.components([.Year, .Month, .Day, .Weekday, .Hour, .Minute], fromDate: date)
        return String(format: "%02d", components.hour) + ":" + String(format: "%02d", components.minute)
    }
    
}
