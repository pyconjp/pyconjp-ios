//
//  PyConJPDate.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/08/04.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

enum PyConJPDate: Int {
    case Tutorials = 0
    case Confarence1 = 1
    case Confarence2 = 2
    case Sprints = 3
    
    var date: String {
        switch self {
        case .Tutorials:
            return "2016-09-20"
        case .Confarence1:
            return "2016-09-21"
        case .Confarence2:
            return "2016-09-22"
        case .Sprints:
            return "2016-09-23"
        }
    }
    
    static func confarenceDate() -> [PyConJPDate] {
        return [PyConJPDate(rawValue: 1)!, PyConJPDate(rawValue: 2)!]
    }
}
