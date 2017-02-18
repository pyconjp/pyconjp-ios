//
//  Room.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 8/7/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

enum TalkRoom: String {
    case Room201 = "Room 201"
    case Room202 = "Room 202"
    case Room203 = "Room 203"
    case Room204 = "Room 204"
    case Room205 = "Room 205"
    
    var number: Int {
        switch self {
        case .Room201: return 201
        case .Room202: return 202
        case .Room203: return 203
        case .Room204: return 204
        case .Room205: return 205
        }
    }
    
    var color: UIColor {
        switch self {
        case .Room201: return UIColor.PyConJP2016.orange
        case .Room202: return UIColor.PyConJP2016.lightOrange
        case .Room203: return UIColor.PyConJP2016.yellow
        case .Room204: return UIColor.PyConJP2016.lightGreen
        case .Room205: return UIColor.PyConJP2016.green
        }
    }
    
    var hashTag: String {
        switch self {
        case .Room201: return "#pyconjp_201"
        case .Room202: return "#pyconjp_202"
        case .Room203: return "#pyconjp_203"
        case .Room204: return "#pyconjp_204"
        case .Room205: return "#pyconjp_205"
        }
    }
    
}
