//
//  BookmarkListDataSource.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2016/08/18.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import Foundation
import Result
import RealmSwift

class BookmarkListDataSource: TimelineDataSource, RealmLoadTalksProtocol {
    
    let filterPredicate = NSPredicate(format: "favorited == %@", true as CVarArg)
    let sortProperties = [SortDescriptor(keyPath: "startDate", ascending: true), SortDescriptor(keyPath: "roomString", ascending: true)]
    
    func refreshData(completionHandler: @escaping ((Result<Void, NSError>) -> Void)) {
        loadTalks { [weak self](result) in
            switch result {
            case .success(let talks):
                self?.timelines.removeAll()
                let keys = talks.map { $0.day }.unique()
                for tuple in keys.enumerated() {
                    self?.timelines.append(Timeline(key: keys[tuple.offset], talks: talks.filter { $0.day == keys[tuple.offset]}))
                }
                completionHandler(.success())
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
