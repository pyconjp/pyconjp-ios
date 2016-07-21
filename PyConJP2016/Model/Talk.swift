//
//  Talk.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 7/11/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit
import RealmSwift

struct Talk {
    
    let id: Int
    let title: String
    let description: String
    let speakers: [String]?
    let date: NSDate?
    let day: String
    let startTime: String
    let endTime: String
    let periodTime: String
    let category: String
    let place: String
    let language: Language
    
}

extension Talk {
    
    init(id: Int, title: String, description: String, speakers: [String]?, day: String, startTime: String, endTime: String, periodTime: String, category: String, place: String, language: String) {
        self.id = id
        self.title = title
        self.description = description
        self.speakers = speakers
        self.date = NSDate.dateFromString(day + " " + startTime)
        self.day = day
        self.startTime = startTime
        self.endTime = endTime
        self.periodTime = periodTime
        self.category = category
        self.place = place
        self.language = Language(rawValue: language) ?? .JA
    }
    
    init(dictionary: [String : AnyObject]) {
        self.init(id: dictionary["id"] as? Int ?? 0,
                  title: dictionary["title"] as? String ?? "",
                  description: dictionary["description"] as? String ?? "",
                  speakers: dictionary["speakers"] as? [String],
                  day: dictionary["day"] as? String ?? "",
                  startTime: dictionary["start"] as? String ?? "",
                  endTime: dictionary["end"] as? String ?? "",
                  periodTime: (dictionary["start"] as? String ?? "") + " ~ " + (dictionary["end"] as? String ?? ""),
                  category: dictionary["category"] as? String ?? "",
                  place: dictionary["rooms"] as? String ?? "",
                  language: dictionary["language"] as? String ?? "")
    }
    
}

class TalkObject: Object {
    dynamic var id =  0
    dynamic var title = ""
    dynamic var descriptionText = ""
    dynamic var speakers = ""
    dynamic var date: NSDate?
    dynamic var day = ""
    dynamic var startTime = ""
    dynamic var endTime = ""
    dynamic var periodTime = ""
    dynamic var category = ""
    dynamic var place = ""
    dynamic var language = "ja"
    
    dynamic var favorited = false
    
    convenience init(dictionary: [String : AnyObject]) {
        self.init()
        id = dictionary["id"] as? Int ?? 0
        title =  dictionary["title"] as? String ?? ""
        descriptionText = dictionary["description"] as? String ?? ""
        (dictionary["speakers"] as? [String] ?? []).forEach { speakers += $0 }
        day = dictionary["day"] as? String ?? ""
        startTime = dictionary["start"] as? String ?? ""
        endTime = dictionary["end"] as? String ?? ""
        date = NSDate.dateFromString(day + " " + startTime)
        periodTime = (dictionary["start"] as? String ?? "") + " ~ " + (dictionary["end"] as? String ?? "")
        category = dictionary["category"] as? String ?? ""
        place = dictionary["rooms"] as? String ?? ""
        language = dictionary["language"] as? String ?? ""
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
