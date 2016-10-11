//
//  ConferenceListDataSource.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/06/13.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import RealmSwift

class ConferenceListDataSource: TimelineDataSource, RealmTalksProtocol {
    
    let filterPredicate: NSPredicate
    let sortProperties = [SortDescriptor(property: "date", ascending: true), SortDescriptor(property: "place", ascending: true)]
    
    init(day: String?) {
        self.filterPredicate = NSPredicate(format: "day == %@", day ?? "")
        super.init()
    }
    
    func refreshData(completionHandler: @escaping ((Result<Void>) -> Void)) -> Void {
        loadTalkObjects { [weak self](result) in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let talks):
                weakSelf.timelines.removeAll()
                let keys = talks.map { $0.startTime }.unique()
                for tuple in keys.enumerated() {
                    weakSelf.timelines.append(Timeline(time: keys[tuple.offset], talks: talks.filter { $0.startTime == keys[tuple.offset]}))
                }
                completionHandler(.success())
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
