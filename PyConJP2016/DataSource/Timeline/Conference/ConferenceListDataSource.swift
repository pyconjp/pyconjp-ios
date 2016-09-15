//
//  ConferenceListDataSource.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/06/13.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import RealmSwift

class ConferenceListDataSource: TimelineDataSource, RealmTalksType {
    
    let filterPredicate: NSPredicate
    let sortProperties = [SortDescriptor(property: "date", ascending: true), SortDescriptor(property: "place", ascending: true)]
    
    init(day: String?) {
        self.filterPredicate = NSPredicate(format: "day == %@", day ?? "")
        super.init()
    }
    
    func refreshData(completionHandler: (Result<Void, NSError> -> Void)) -> Void {
        loadTalkObjects { [weak self](result) in
            guard let weakSelf = self else { return }
            switch result {
            case .Success(let talks):
                weakSelf.timelines.removeAll()
                let keys = talks.map { $0.startTime }.unique()
                for tuple in keys.enumerate() {
                    weakSelf.timelines.append(Timeline(time: keys[tuple.index], talks: talks.filter { $0.startTime == keys[tuple.index]}))
                }
                completionHandler(.Success())
            case .Failure(let error):
                completionHandler(.Failure(error))
            }
        }
    }
    
}
