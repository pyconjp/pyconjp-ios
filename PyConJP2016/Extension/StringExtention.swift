//
//  StringExtention.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/07/22.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

extension String {
    func timeStringByTrimingSecond() -> String {
        let dateString = "2000-01-01 " + self
        guard let date = NSDate.dateFromString(dateString) else { return self }
        return NSDate.timeFromDate(date)
    }
}
