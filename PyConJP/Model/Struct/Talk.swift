//
//  Talk.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 7/11/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

struct Talk {
    
    let id: Int
    let title: String
    let description: String
    let speakers: [String]
    let startDate: Date
    let endDate: Date
    let day: String
    let startTime: String
    let endTime: String
    let category: String
    let room: Room
    let language: Language
    
}

extension Talk {
    
    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? Int,
            let title =  dictionary["title"] as? String,
            let description = dictionary["description"] as? String,
            let speakers = dictionary["speakers"] as? [String],
            let day = dictionary["day"] as? String,
            let startTime = dictionary["start"] as? String,
            let startDate = Date.date(from: day + " " + startTime),
            let endTime = dictionary["end"] as? String,
            let endDate = Date.date(from: day + " " + endTime),
            let category = dictionary["category"] as? String,
            let room = Room(dictionary["rooms"] as? String ?? ""),
            let language = Language(dictionary["language"] as? String ?? "") else { return nil }

        self.init(id: id,
                  title: title,
                  description: description,
                  speakers: speakers,
                  startDate: startDate,
                  endDate: endDate,
                  day: day,
                  startTime: startTime,
                  endTime: endTime,
                  category: category,
                  room: room,
                  language: language)
    }
    
    init?(_ talkObject: TalkObject) {
        guard let room = talkObject.room,
        let language = talkObject.language else { return nil }
        self.init(id: talkObject.id,
                  title: talkObject.title,
                  description: talkObject.descriptionText,
                  speakers: talkObject.speakers.components(separatedBy: ", "),
                  startDate: talkObject.startDate,
                  endDate: talkObject.endDate,
                  day: talkObject.day,
                  startTime: talkObject.startTime,
                  endTime: talkObject.endTime,
                  category: talkObject.category,
                  room: room,
                  language: language)
    }
    
}
