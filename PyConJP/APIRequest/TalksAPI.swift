//
//  TalksAPI.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/06/12.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import Foundation
import APIKit
import Result
import RealmSwift

struct TalksAPI {
    
    func getTalks(completionHandler: @escaping ((Result<Void, SessionTaskError>) -> Void)) {
        let request = TalksAPIRequest()
        Session.send(request) { result in
            switch result {
            case .success(let talks):
                let realm = try? Realm()
                let rejectedTalks = realm?.objects(TalkObject.self).filter("NOT(id IN %@)", talks.map({ $0.id }))
                try? realm?.write({
                    if let rejectedTalks = rejectedTalks {
                        realm?.delete(rejectedTalks)
                    }
                    realm?.add(talks, update: true)
                })
                completionHandler(.success())
//                do {
//                    let realm = try Realm()
//                    let rejectedLocalTalks = realm.objects(TalkObject.self).filter("NOT(id IN %@)", talks.map({ $0.id }))
//                    try realm.write({
//                        realm.delete(rejectedLocalTalks)
//                        realm.add(talks, update: true)
//                    })
//                } catch {
//                    
//                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
