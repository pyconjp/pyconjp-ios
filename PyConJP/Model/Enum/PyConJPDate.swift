//
//  PyConJPDate.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2016/08/04.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import Foundation

enum PyConJPDate: CustomStringConvertible {
    case tutorials
    case confarence1
    case confarence2
    case sprints
    
    var description: String {
        switch self {
        case .tutorials: return "2016-09-20"
        case .confarence1: return "2016-09-21"
        case .confarence2: return "2016-09-22"
        case .sprints: return "2016-09-23"
        }
    }
    
    static func confarenceDate() -> [PyConJPDate] {
        return [confarence1, confarence2]
    }
}
