//
//  TalkObject.swift
//  PyConJP
//
//  Created by Yutaro Muta on 7/11/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import Foundation
import APIKit
import RealmSwift

final class TalkObject: RealmSwift.Object {
    
    dynamic var id: Int = 0
    dynamic var title: String = ""
    dynamic var descriptionText: String = ""
    dynamic var speakers: String = ""
    dynamic var startDate: Date = Date()
    dynamic var endDate: Date = Date()
    dynamic var day: String = ""
    dynamic var startTime: String = ""
    dynamic var endTime: String = ""
    dynamic var category: String = ""
    dynamic var roomString: String = ""
    dynamic var languageString: String = ""
    dynamic var isFavorite: Bool = false
    
    convenience init(id: Int, title: String, descriptionText: String, speakers: String, startDate: Date, endDate: Date, day: String, startTime: String, endTime: String, category: String, roomString: String, languageString: String, isFavorite: Bool) {
        self.init()
        self.id = id
        self.title =  title
        self.descriptionText = descriptionText
        self.speakers = speakers
        self.startDate = startDate
        self.endDate = endDate
        self.day = day
        self.startTime = startTime
        self.endTime = endTime
        self.category = category
        self.roomString = roomString
        self.languageString = languageString
        self.isFavorite = isFavorite
    }
    
    convenience init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? Int,
            let title =  dictionary["title"] as? String,
            let descriptionText = dictionary["description"] as? String,
            let day = dictionary["day"] as? String,
            let startTime = dictionary["start"] as? String,
            let startDate = Date.date(from: day + " " + startTime),
            let endTime = dictionary["end"] as? String,
            let endDate = Date.date(from: day + " " + endTime),
            let category = dictionary["category"] as? String,
            let roomString = dictionary["rooms"] as? String,
            let language = dictionary["language"] as? String else { return nil }
        
        let speakers = (dictionary["speakers"] as? [String] ?? []).enumerated().reduce("") {
            $0 + $1.element + ((dictionary["speakers"] as? [String] ?? []).count - 1 == $1.offset ? "" : ", ")
        }

        let isFavorite: Bool = {
            let realm = try? Realm()
            guard let localTalkObject = (realm?.objects(TalkObject.self).filter("id == %@", id).map { $0 })?.first else { return false }
            return localTalkObject.isFavorite
        }()
        
        self.init(id: id,
                  title: title,
                  descriptionText: descriptionText,
                  speakers: speakers,
                  startDate: startDate,
                  endDate: endDate,
                  day: day,
                  startTime: startTime,
                  endTime: endTime,
                  category: category,
                  roomString: roomString,
                  languageString: language,
                  isFavorite: isFavorite)
    }
    
    convenience init?(object: Any) {
        guard let dictionary = object as? [String: Any] else {
            return nil
        }
        self.init(dictionary: dictionary)
    }
    
    convenience init(_ talk: Talk) {
        let speakersString = talk.speakers.enumerated().reduce("") {
            $0 + $1.element + (talk.speakers.count - 1 == $1.offset ? "" : ", ")
        }
        let isFavorite: Bool = {
            let realm = try? Realm()
            guard let localTalkObject = (realm?.objects(TalkObject.self).filter("id == %@", talk.id).map { $0 })?.first else { return false }
            return localTalkObject.isFavorite
        }()
        self.init(id: talk.id,
                  title: talk.title,
                  descriptionText: talk.description,
                  speakers: speakersString,
                  startDate: talk.startDate,
                  endDate: talk.endDate,
                  day: talk.day,
                  startTime: talk.startTime,
                  endTime: talk.endTime,
                  category: talk.category,
                  roomString: talk.room.description,
                  languageString: talk.language.description,
                  isFavorite: isFavorite)
    }

    override static func primaryKey() -> String? {
        return "id"
    }
    
    var periodTime: String {
        return startTime.timeStringByTrimmingSecond() + " ~ " + endTime.timeStringByTrimmingSecond()
    }
    
    var language: Language? {
        return Language(languageString)
    }
    
    var placeNumber: String {
        return self.roomString.components(separatedBy: CharacterSet.decimalDigits.inverted).last ?? ""
    }
    
    var room: Room? {
        return Room(roomString)
    }
    
    func invertFavorite() throws {
        do {
            self.isFavorite = !self.isFavorite
            let realm = try Realm()
            try realm.write({
                realm.create(TalkObject.self, value: ["id": self.id, "isFavorite": self.isFavorite], update: true)
            })
        } catch {
            throw error
        }
    }
    
}
