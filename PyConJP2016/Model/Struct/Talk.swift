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
    let speakers: [String]?
    let date: Date?
    let day: String
    let startTime: String
    let endTime: String
    let periodTime: String
    let category: String
    let place: String
    let language: Language
    
}

extension Talk {
    
    init(id: Int, title: String, description: String, speakers: [String]?, day: String, startTime: String, endTime: String, category: String, place: String, language: String) {
        self.id = id
        self.title = title
        self.description = description
        self.speakers = speakers
        self.date = Date.date(from: day + " " + startTime)
        self.day = day
        self.startTime = startTime
        self.endTime = endTime
        self.periodTime = startTime.timeStringByTrimmingSecond() + " ~ " + endTime.timeStringByTrimmingSecond()
        self.category = category
        self.place = place
        self.language = Language(rawValue: language) ?? .En
    }
    
    init(dictionary: Dictionary<String, AnyObject>) {
        self.init(id: dictionary["id"] as? Int ?? 0,
                  title: dictionary["title"] as? String ?? "",
                  description: dictionary["description"] as? String ?? "",
                  speakers: dictionary["speakers"] as? [String],
                  day: dictionary["day"] as? String ?? "",
                  startTime: dictionary["start"] as? String ?? "",
                  endTime: dictionary["end"] as? String ?? "",
                  category: dictionary["category"] as? String ?? "",
                  place: dictionary["rooms"] as? String ?? "",
                  language: dictionary["language"] as? String ?? "")
    }
    
}
