//
//  NSDateExtension.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 7/18/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

extension Date {
    
    static private let dateFormatterInstance: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()
    
    static func date(from string: String) -> Date? {
        return dateFormatterInstance.date(from: string)
    }
    
    func convertToTime() -> String {
        let calender = Calendar(identifier: Calendar.Identifier.gregorian)
        let components = (calender as NSCalendar).components([.year, .month, .day, .weekday, .hour, .minute], from: self)
        return String(format: "%02d", components.hour!) + ":" + String(format: "%02d", components.minute!)
    }
    
}
