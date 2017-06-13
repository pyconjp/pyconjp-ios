//
//  RealmSaveTalksProtocol.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/06/13.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import Foundation
import Result
import RealmSwift

protocol RealmSaveTalksProtocol {
    
    func save(talks: [TalkObject]) throws
    func save(talks: [TalkObject], completionHandler: @escaping ((Result<Void, NSError>) -> Void))
    
}

extension RealmSaveTalksProtocol {
    
    func save(talks: [TalkObject]) throws {
        do {
            let realm = try Realm()
            let rejectedTalks = realm.objects(TalkObject.self).filter("NOT(id IN %@)", talks.map({ $0.id }))
            try realm.write({
                realm.delete(rejectedTalks)
                realm.add(talks, update: true)
            })
        } catch let error as NSError {
            throw error
        }
    }
    
    func save(talks: [TalkObject], completionHandler: @escaping ((Result<Void, NSError>) -> Void)) {
        do {
            let realm = try Realm()
            let rejectedTalks = realm.objects(TalkObject.self).filter("NOT(id IN %@)", talks.map({ $0.id }))
            try realm.write({
                realm.delete(rejectedTalks)
                realm.add(talks, update: true)
            })
            completionHandler(.success())
        } catch let error as NSError {
            completionHandler(.failure(error))
        }
    }
    
}
