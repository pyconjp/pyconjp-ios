//
//  Room.swift
//  PyConJP
//
//  Created by Yutaro Muta on 8/7/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

enum Room: CustomStringConvertible {
    case room201
    case room202
    case room203
    
    static var rooms: [Room] {
        return [.room201, .room202, .room203]
    }
    
    var description: String {
        switch self {
        case .room201: return "Room 201"
        case .room202: return "Room 202"
        case .room203: return "Room 203"
        }
    }
    
    var number: Int {
        switch self {
        case .room201: return 201
        case .room202: return 202
        case .room203: return 203
        }
    }
    
    var color: UIColor {
        switch self {
        case .room201: return UIColor.navy
        case .room202: return UIColor.goldenrod
        case .room203: return UIColor.crimson
        }
    }
    
    var hashTag: String {
        switch self {
        case .room201: return "#pyconjp_201"
        case .room202: return "#pyconjp_202"
        case .room203: return "#pyconjp_203"
        }
    }
    
    init?(_ string: String) {
        switch string {
        case Room.room201.description: self = .room201
        case Room.room202.description: self = .room202
        case Room.room203.description: self = .room203
        default: return nil
        }
    }
    
}
