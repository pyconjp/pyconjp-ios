//
//  RealmLoadTalksProtocol.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/08/18.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import Result
import RealmSwift

protocol RealmLoadTalksProtocol {
    var filterPredicate: NSPredicate { get }
    var sortProperties: [SortDescriptor] { get }
    
    func loadTalks(completionHandler: ((Result<[TalkObject], NSError>) -> Void))
}

extension RealmLoadTalksProtocol {
    
    func loadTalks(completionHandler: ((Result<[TalkObject], NSError>) -> Void)) {
        do {
            let realm = try Realm()
            let talks = Array(realm.objects(TalkObject.self).filter(filterPredicate).sorted(by: sortProperties))
            completionHandler(.success(talks))
        } catch let error as NSError {
            completionHandler(.failure(error))
        }
    }

}
