//
//  ConferenceListDataSource.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/06/13.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import APIKit
import Result
import RealmSwift

class ConferenceListDataSource: TimelineDataSource, RealmLoadTalksProtocol, RealmSaveTalksProtocol {
    
    let filterPredicate: NSPredicate
    let sortProperties = [SortDescriptor(keyPath: "startDate", ascending: true), SortDescriptor(keyPath: "roomString", ascending: true)]
    
    init(day: String?) {
        self.filterPredicate = NSPredicate(format: "day == %@", day ?? "")
        super.init()
    }
    
    func getTalksFromAPI(completionHandler: @escaping ((Result<Void, SessionTaskError>) -> Void)) {
        let request = TalksAPIRequest()
        Session.send(request) { [weak self](result) in
            switch result {
            case .success(let talks):
                try? self?.save(talks: talks)
                completionHandler(.success())
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func refreshData(completionHandler: @escaping ((Result<Void, NSError>) -> Void)) {
        loadTalks { [weak self](result) in
            switch result {
            case .success(let talks):
                self?.timelines.removeAll()
                let keys = talks.map { $0.startTime }.unique()
                for tuple in keys.enumerated() {
                    self?.timelines.append(Timeline(time: keys[tuple.offset], talks: talks.filter { $0.startTime == keys[tuple.offset]}))
                }
                completionHandler(.success())
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
