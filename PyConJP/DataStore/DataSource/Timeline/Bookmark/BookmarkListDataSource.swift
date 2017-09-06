//
//  BookmarkListDataSource.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2016/08/18.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import Foundation
import Result

class BookmarkListDataSource: TimelineDataSource {
    
    private let loadTalksRequest = LoadFavoriteTalksRequest()
    
    func refreshData(completionHandler: @escaping ((Result<Void, NSError>) -> Void)) {
        do {
            let talks = try loadTalksRequest.load()
            timelines.removeAll()
            let keys = talks.map { $0.day }.unique()
            for tuple in keys.enumerated() {
                timelines.append(Timeline(key: keys[tuple.offset], talks: talks.filter { $0.day == keys[tuple.offset]}))
            }
            completionHandler(.success())
        } catch let error as NSError {
            completionHandler(.failure(error))
        }
    }
    
}
