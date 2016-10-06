//
//  TalksAPIType.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 4/23/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import RealmSwift

protocol TalksAPIType: AlamofireType {
    func getTalks(successClosure success: @escaping () -> Void, failClosure fail: @escaping (Error) -> Void) -> Void
    func getTalks(_ completionHandler: @escaping ((Result<Void>) -> Void)) -> Void
    func getTalksFromLocalDummyJson(_ completionHandler: ((Result<Void>) -> Void)) -> Void
}

extension TalksAPIType {
    
    var path: String {
        return "talks/list/"
    }
    
}

extension TalksAPIType {
    
    func getTalks(successClosure success: @escaping () -> Void, failClosure fail: @escaping (Error) -> Void) -> Void {
        get(successClosure: { dictionary in
            let presentations = dictionary["presentations"] as? Array<Dictionary<String, AnyObject>> ?? [Dictionary<String, AnyObject>]()
            
            do {
                let apiTalks = presentations.map({ TalkObject(dictionary: $0) })
                
                let realm = try Realm()
                let rejectedLocalTalks = realm.objects(TalkObject.self).filter("NOT(id IN %@)", apiTalks.map({ $0.id }))
                try realm.write({
                    realm.delete(rejectedLocalTalks)
                    realm.add(apiTalks, update: true)
                })
                
                success()
            } catch let error {
                fail(error)
            }
            
            }, failClosure: { error in
                fail(error)
        })
    }
    
    func getTalks(_ completionHandler: @escaping ((Result<Void>) -> Void)) -> Void {
        get() { result in
            switch result {
            case .success(let value):
                let presentations = value["presentations"] as? Array<Dictionary<String, AnyObject>> ?? [Dictionary<String, AnyObject>]()
                
                do {
                    let apiTalks = presentations.map({ TalkObject(dictionary: $0) })
                    
                    let realm = try Realm()
                    let rejectedLocalTalks = realm.objects(TalkObject.self).filter("NOT(id IN %@)", apiTalks.map({ $0.id }))
                    try realm.write({
                        realm.delete(rejectedLocalTalks)
                        realm.add(apiTalks, update: true)
                    })
                    
                    completionHandler(.success())
                } catch let error as NSError {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getTalksFromLocalDummyJson(_ completionHandler: ((Result<Void>) -> Void)) -> Void {
        let path = Bundle.main.path(forResource: "DummyTalks", ofType: "json")
        let fileHandle = FileHandle(forReadingAtPath: path!)
        let data = fileHandle?.readDataToEndOfFile()
        let dictionary = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String, AnyObject>
        let presentations = dictionary["presentations"] as? Array<Dictionary<String, AnyObject>> ?? [Dictionary<String, AnyObject>]()
        
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
