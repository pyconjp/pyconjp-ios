//
//  RealmTalksProtocol.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/08/18.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import RealmSwift

protocol RealmTalksProtocol {
    var filterPredicate: NSPredicate { get }
    var sortProperties: Array<SortDescriptor> { get }
    
    func loadTalkObjects(_ completionHandler: ((Result<Array<TalkObject>>) -> Void)) -> Void
}

extension RealmTalksProtocol {
    
    func loadTalkObjects(_ completionHandler: ((Result<Array<TalkObject>>) -> Void)) -> Void {
        do {
            let realm = try Realm()
            let talks = Array(realm.objects(TalkObject.self).filter(filterPredicate).sorted(by: sortProperties))
            completionHandler(.success(talks))
        } catch let error as NSError {
            completionHandler(.failure(error))
        }
    }

}
