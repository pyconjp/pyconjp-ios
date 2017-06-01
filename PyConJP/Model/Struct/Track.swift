//
//  Track.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/06/01.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import Foundation

struct Track {
    let room: Room
    let talks: [TalkObject]
    
    var start: Date? {
        return talks.min(by: { $0.0.startDate < $0.1.startDate })?.startDate
    }
    
    var end: Date? {
        return talks.max(by: { $0.0.startDate < $0.1.startDate })?.startDate
    }
    
}
