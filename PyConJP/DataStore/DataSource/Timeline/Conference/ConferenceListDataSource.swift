//
//  ConferenceListDataSource.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2016/06/13.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import Foundation
import APIKit
import Result

class ConferenceListDataSource: TimelineDataSource {
    
    private let loadTalksRequest: LoadTalksRequest
    
    init(day: String?) {
        self.loadTalksRequest = LoadTalksRequest(day: day)
        super.init()
    }
    
    func getTalksFromAPI(completionHandler: @escaping ((Result<Void, SessionTaskError>) -> Void)) {
        let request = TalksAPIRequest()
        Session.send(request) { result in
            switch result {
            case .success(let talks):
                try? SaveTalksRequest().save(talks: talks)
                completionHandler(.success())
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func refreshData(completionHandler: @escaping ((Result<Void, NSError>) -> Void)) {
        do {
            let talks = try loadTalksRequest.load()
            timelines.removeAll()
            let keys = talks.map { $0.startTime }.unique()
            for tuple in keys.enumerated() {
                timelines.append(Timeline(time: keys[tuple.offset], talks: talks.filter { $0.startTime == keys[tuple.offset]}))
            }
            completionHandler(.success())
        } catch let error as NSError {
            completionHandler(.failure(error))
        }
    }
    
}
