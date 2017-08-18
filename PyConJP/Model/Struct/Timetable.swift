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

    var duration: Double? {
        guard let start = start,
            let end = end else { return nil }
        return end.timeIntervalSince(start)
    }
    
    var minutesDuration: Int {
        return Int((duration ?? 0) / 60)
    }

    var hours: Int {
        return minutesDuration / 60
    }
    
    var hourDuration: [Int] {
        guard let startHourClock = start?.components.hour,
            let endHourClock = end?.components.hour else { return [] }
        return Array(startHourClock...endHourClock)
    }
    
    init(talks: [TalkObject]) {
        self.tracks = Room.rooms.map { room -> Track in
            Track(room: room, talks: talks.filter({ $0.room == room }))
        }
    }
    
}
