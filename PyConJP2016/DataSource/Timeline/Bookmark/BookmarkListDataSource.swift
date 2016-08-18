//
//  BookmarkListDataSource.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/08/18.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import RealmSwift

class BookmarkListDataSource: TimelineDataSource, RealmTalksType {
    
    let filterPredicate = NSPredicate(format: "favorited == %@", true)
    let sortProperties = [SortDescriptor(property: "date", ascending: true), SortDescriptor(property: "place", ascending: true)]
    
    func refreshData() {
        timelines.removeAll()
        loadTalkObjects({ result in
            switch result {
            case .Success(let talks):
                let keys = talks.map { $0.day }.unique()
                for tuple in keys.enumerate() {
                    self.timelines.append(Timeline(key: keys[tuple.index], talks: talks.filter { $0.day == keys[tuple.index]}))
                }
                break
            case .Failure: break
            }
        })
    }
    
}
