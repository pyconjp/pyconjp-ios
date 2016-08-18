//
//  ScheduleListDataSource.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/06/13.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import RealmSwift

class ScheduleListDataSource: TimelineDataSource, RealmTalksType {
    
    let filterPredicate: NSPredicate
    let sortProperties = [SortDescriptor(property: "date", ascending: true), SortDescriptor(property: "place", ascending: true)]
    
    init(day: String?) {
        self.filterPredicate = NSPredicate(format: "day == %@", day ?? "")
        super.init()
    }
    
    func refreshData() {
        timelines.removeAll()
        loadTalkObjects { result in
            switch result {
            case .Success(let talks):
                let keys = talks.map { $0.startTime }.unique()
                for tuple in keys.enumerate() {
                    self.timelines.append(Timeline(time: keys[tuple.index], talks: talks.filter { $0.startTime == keys[tuple.index]}))
                }
            case .Failure: break
            }
        }
    }
    
}
