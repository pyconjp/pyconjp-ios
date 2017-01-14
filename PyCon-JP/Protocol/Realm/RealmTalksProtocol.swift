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
    var sortProperties: [SortDescriptor] { get }
    
    func loadTalkObjects(_ completionHandler: ((Result<[TalkObject]>) -> Void)) -> Void
    func getTalksFromLocalDummyJson(completionHandler: ((Result<Void>) -> Void)) -> Void
}

extension RealmTalksProtocol {
    
    func loadTalkObjects(_ completionHandler: ((Result<[TalkObject]>) -> Void)) -> Void {
        do {
            let realm = try Realm()
            let talks = Array(realm.objects(TalkObject.self).filter(filterPredicate).sorted(by: sortProperties))
            completionHandler(.success(talks))
        } catch let error as NSError {
            completionHandler(.failure(error))
        }
    }

}

extension RealmTalksProtocol {
    
    func getTalksFromLocalDummyJson(completionHandler: ((Result<Void>) -> Void)) -> Void {
        let path = Bundle.main.path(forResource: "DummyTalks", ofType: "json")
        let fileHandle = FileHandle(forReadingAtPath: path!)
        let data = fileHandle?.readDataToEndOfFile()
        let dictionary = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
        let presentations = dictionary["presentations"] as? [[String: Any]] ?? [[String: Any]]()
        
        do {
            let realm = try Realm()
            try realm.write({
                presentations.forEach({
                    let talkObject = TalkObject(dictionary: $0)
                    realm.add(talkObject, update: true)
                })
            })
            
            completionHandler(.success())
        } catch let error as NSError {
            completionHandler(.failure(error))
        }
        
    }
    
}
