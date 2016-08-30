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
        case .Room201: return UIColor.pyconJP2016OrangeColor()
        case .Room202: return UIColor.pyconJP2016LightOrangeColor()
        case .Room203: return UIColor.pyconJP2016YellowColor()
        case .Room204: return UIColor.pyconJP2016LightGreenColor()
        case .Room205: return UIColor.pyconJP2016GreenColor()
        }
    }
    
    var hashTag: String {
        switch self {
        case .Room201: return "pyconjp_1"
        case .Room202: return "pyconjp_2"
        case .Room203: return "pyconjp_3"
        case .Room204: return "pyconjp_4"
        case .Room205: return "pyconjp_5"
        }
    }
    
}
