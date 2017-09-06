//
//  RealmLoadTalksProtocol.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2016/08/18.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmLoadTalksProtocol {
    var filterPredicate: NSPredicate { get }
    var sortProperties: [SortDescriptor] { get }
    
    func load() throws -> [TalkObject]
}

extension RealmLoadTalksProtocol {
    
    func load() throws -> [TalkObject] {
        do {
            let realm = try Realm()
            return Array(realm.objects(TalkObject.self).filter(filterPredicate).sorted(by: sortProperties))
        } catch {
            throw error
        }
    }

}
