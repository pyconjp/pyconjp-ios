//
//  Timetable.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/06/01.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import Foundation

struct Timetable {
    
    let tracks: [Track]
    
    var start: Date? {
        return tracks.flatMap({ $0.start }).min()
    }
    
    var end : Date? {
        return tracks.flatMap({ $0.end }).max()
    }
    
    var timeLength: Double? {
        guard let start = start,
            let end = end else { return nil }
        return end.timeIntervalSince(start) / 60
    }
    
    //        init(talks: [TalkObject]) {
    ////            let hoge = TalkRoom.
    //        }
    
}
