//
//  NSDateExtension.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 7/18/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

extension NSDate {
    class func dateFromString(stringDate: String) -> NSDate? {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.dateFromString(stringDate)
    }
    
    class func timeFromDate(date: NSDate) -> String {
        let calender = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = calender?.components([.Year, .Month, .Day, .Weekday, .Hour, .Minute], fromDate: date)
        return "\(components?.hour):\(components?.minute)"
    }

}
