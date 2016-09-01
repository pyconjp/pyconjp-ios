//
//  StringExtention.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/07/22.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

extension String {
    
    func convertToDate() -> NSDate? {
        
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: NSDateFormatter! = nil
        }
        
        dispatch_once(&Static.onceToken) {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            Static.instance = formatter
        }
        
        return Static.instance.dateFromString(self)
    }
    
    func timeStringByTrimingSecond() -> String {
        let dateString = "2000-01-01 " + self
        guard let date = NSDate.dateFromString(dateString) else { return self }
        return date.convertToTime()
    }
    
}
