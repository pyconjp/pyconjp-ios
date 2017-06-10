//
//  Room.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 8/7/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

enum Room: CustomStringConvertible {
    case room201
    case room202
    case room203
    case room204
    case room205
    
    static var rooms: [Room] {
        return [.room201, .room202, .room203, .room204, .room205]
    }
    
    var description: String {
        switch self {
        case .room201: return "Room 201"
        case .room202: return "Room 202"
        case .room203: return "Room 203"
        case .room204: return "Room 204"
        case .room205: return "Room 205"
        }
    }
    
    var number: Int {
        switch self {
        case .room201: return 201
        case .room202: return 202
        case .room203: return 203
        case .room204: return 204
        case .room205: return 205
        }
    }
    
    var color: UIColor {
        switch self {
        case .room201: return UIColor.PyConJP2016.orange
        case .room202: return UIColor.PyConJP2016.lightOrange
        case .room203: return UIColor.PyConJP2016.yellow
        case .room204: return UIColor.PyConJP2016.lightGreen
        case .room205: return UIColor.PyConJP2016.green
        }
    }
    
    var hashTag: String {
        switch self {
        case .room201: return "#pyconjp_201"
        case .room202: return "#pyconjp_202"
        case .room203: return "#pyconjp_203"
        case .room204: return "#pyconjp_204"
        case .room205: return "#pyconjp_205"
        }
    }
    
    init?(_ string: String) {
        switch string {
        case Room.room201.description: self = .room201
        case Room.room202.description: self = .room202
        case Room.room203.description: self = .room203
        case Room.room204.description: self = .room204
        case Room.room205.description: self = .room205
        default: return nil
        }
    }
    
}
