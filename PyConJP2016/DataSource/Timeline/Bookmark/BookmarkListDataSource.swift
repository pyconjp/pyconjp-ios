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
    
    func refreshData(completionHandler: (Result<Void, NSError> -> Void)) -> Void {
        loadTalkObjects { [weak self](result) in
            guard let weakSelf = self else { return }
            switch result {
            case .Success(let talks):
                weakSelf.timelines.removeAll()
                let keys = talks.map { $0.day }.unique()
                for tuple in keys.enumerate() {
                    weakSelf.timelines.append(Timeline(key: keys[tuple.index], talks: talks.filter { $0.day == keys[tuple.index]}))
                }
                completionHandler(.Success())
            case .Failure(let error):
                completionHandler(.Failure(error))
            }
        }
    }
    
}
