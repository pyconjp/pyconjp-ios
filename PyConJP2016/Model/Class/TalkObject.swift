//
//  TalkObject.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 7/11/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import RealmSwift

class TalkObject: RealmSwift.Object {
    dynamic var id =  0
    dynamic var title = ""
    dynamic var descriptionText = ""
    dynamic var speakers = ""
    dynamic var date: Date?
    dynamic var day = ""
    dynamic var startTime = ""
    dynamic var endTime = ""
    dynamic var periodTime = ""
    dynamic var category = ""
    dynamic var place = ""
    dynamic var language = ""
    dynamic var favorited = false
    
    convenience init(dictionary: Dictionary<String, Any>) {
        self.init()
        id = dictionary["id"] as? Int ?? 0
        title =  dictionary["title"] as? String ?? ""
        descriptionText = dictionary["description"] as? String ?? ""
        speakers = (dictionary["speakers"] as? [String] ?? []).enumerated().reduce("") {
            $0 + $1.element + ((dictionary["speakers"] as? [String] ?? []).count - 1 == $1.offset ? "" : ", ")
        }
        date = Date.date(from: (dictionary["day"] as? String ?? "") + " " + (dictionary["start"] as? String ?? ""))
        day = dictionary["day"] as? String ?? ""
        startTime = dictionary["start"] as? String ?? ""
        endTime = dictionary["end"] as? String ?? ""
        periodTime = (dictionary["start"] as? String ?? "").timeStringByTrimmingSecond() + " ~ " + (dictionary["end"] as? String ?? "").timeStringByTrimmingSecond()
        category = dictionary["category"] as? String ?? ""
        place = dictionary["rooms"] as? String ?? ""
        language = dictionary["language"] as? String ?? ""
        
        do {
            let realm = try Realm()
            if let localTalkObject = (realm.objects(TalkObject.self).filter("id == %@", id).map { $0 }).first {
                favorited = localTalkObject.favorited
            }
        } catch {
            
        }
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    var languageType: Language? {
        return Language(rawValue: language)
    }
    
    var placeNumber: String {
        return self.place.components(separatedBy: CharacterSet.decimalDigits.inverted).last ?? ""
    }
    
    var room: TalkRoom? {
        return TalkRoom(rawValue: place)
    }
    
}
