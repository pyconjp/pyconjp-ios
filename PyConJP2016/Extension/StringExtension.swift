//
//  StringExtension.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/07/22.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

extension String {
    
    static private let dateFormatterInstance: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()
    
    func convertToDate() -> Date? {
        return String.dateFormatterInstance.date(from: self)
    }
    
    func timeStringByTrimmingSecond() -> String {
        let dateString = "2000-01-01 " + self
        guard let date = Date.date(from: dateString) else { return self }
        return date.convertToTime()
    }
    
}
