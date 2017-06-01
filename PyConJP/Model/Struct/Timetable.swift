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
    
    var timeLength: Double? {
        guard let start = tracks.flatMap({ $0.start }).min(),
            let end = tracks.flatMap({ $0.end }).max() else { return nil }
        return end.timeIntervalSince(start) / 60
    }
    
    //        init(talks: [TalkObject]) {
    ////            let hoge = TalkRoom.
    //        }
    
}
