//
//  NotificationType.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/06/15.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import Foundation

enum NotificationType: CustomStringConvertible {
    case information
    case talk
    
    var description: String {
        switch self {
        case .information:
            return "information"
        case .talk:
            return "talk"
        }
    }
    
    init?(_ stting: String) {
        switch stting {
        case NotificationType.information.description:
            self = .information
        case NotificationType.talk.description:
            self = .talk
        default:
            return nil
        }
    }
    
}
