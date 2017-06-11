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
    
    var rooms: [Room] {
        return tracks.map({ $0.room })
    }
    
    var start: Date? {
        return tracks.flatMap({ $0.start }).min()
    }
    
    var end: Date? {
        return tracks.flatMap({ $0.end }).max()
    }
    
    var timeLength: Double? {
        guard let start = start,
            let end = end else { return nil }
        return end.timeIntervalSince(start) / 60
    }
    
    init(talks: [TalkObject]) {
        self.tracks = Room.rooms.map { room -> Track in
            Track(room: room, talks: talks.filter({ $0.room == room }))
        }
    }
    
}
