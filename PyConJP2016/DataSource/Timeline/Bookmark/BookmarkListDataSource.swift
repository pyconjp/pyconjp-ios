//
//  BookmarkListDataSource.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/08/18.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import RealmSwift

class BookmarkListDataSource: TimelineDataSource, RealmTalksProtocol {
    
    let filterPredicate = NSPredicate(format: "favorited == %@", true as CVarArg)
    let sortProperties = [SortDescriptor(property: "date", ascending: true), SortDescriptor(property: "place", ascending: true)]
    
    func refreshData(completionHandler: @escaping ((Result<Void>) -> Void)) -> Void {
        loadTalkObjects { [weak self](result) in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let talks):
                weakSelf.timelines.removeAll()
                let keys = talks.map { $0.day }.unique()
                for tuple in keys.enumerated() {
                    weakSelf.timelines.append(Timeline(key: keys[tuple.offset], talks: talks.filter { $0.day == keys[tuple.offset]}))
                }
                completionHandler(.success())
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
