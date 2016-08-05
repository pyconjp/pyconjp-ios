//
//  PyConJPDate.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/08/04.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

enum PyConJPDate: String {
    case Tutorials = "2016-09-20"
    case Confarence1 = "2016-09-21"
    case Confarence2 = "2016-09-22"
    case Sprints = "2016-09-23"
    
//    var date: String {
//        switch self {
//        case .Tutorials:
//            return "2016-09-20"
//        case .Confarence1:
//            return "2016-09-21"
//        case .Confarence2:
//            return "2016-09-22"
//        case .Sprints:
//            return "2016-09-23"
//        }
//    }
    
    static func confarenceDate() -> [PyConJPDate] {
        return [PyConJPDate.Confarence1, PyConJPDate.Confarence2]
    }
}
