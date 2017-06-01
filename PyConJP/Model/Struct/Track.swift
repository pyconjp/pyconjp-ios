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
        return talks.flatMap({ $0.startDate }).min()
    }
    
    var end: Date? {
        return talks.flatMap({ $0.endDate }).max()
    }
    
}
