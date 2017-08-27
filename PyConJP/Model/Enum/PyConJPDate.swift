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
        case .tutorials: return "2017-09-07"
        case .confarence1: return "2017-09-08"
        case .confarence2: return "2017-09-09"
        case .sprints: return "2017-09-10"
        }
    }
    
    static func confarenceDate() -> [PyConJPDate] {
        return [confarence1, confarence2]
    }
}
