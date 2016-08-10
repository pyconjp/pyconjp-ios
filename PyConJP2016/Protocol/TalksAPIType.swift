//
//  TalksAPIType.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 4/23/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit
import RealmSwift

protocol TalksAPIType: AlamofireType {
    func getTalks(successClosure success: () -> Void, failClosure fail: (NSError) -> Void) -> Void
    func getTalks(completionHandler: (Result<Void, NSError> -> Void)) -> Void
    func getTalksFromLocalDummyJson(completionHandler: (Result<Void, NSError> -> Void)) -> Void
}

extension TalksAPIType {
    
    var path: String {
        return "talks/list/"
    }
    
}

extension TalksAPIType {
    
    func getTalks(successClosure success: () -> Void, failClosure fail: (NSError) -> Void) -> Void {
        get(successClosure: { dictionary in
            let presentations = dictionary["presentations"] as? Array<Dictionary<String, AnyObject>> ?? [Dictionary<String, AnyObject>]()
            
            do {
                let realm = try Realm()
                try realm.write({
                    presentations.forEach({
                        let talkObject = TalkObject(dictionary: $0)
                        realm.add(talkObject, update: true)
                    })
                })
                
                success()
            } catch let error as NSError {
                fail(error)
            }
            
            }, failClosure: { error in
                fail(error)
        })
    }
    
    func getTalks(completionHandler: (Result<Void, NSError> -> Void)) -> Void {
        get() { result in
            switch result {
            case .Success(let value):
                let presentations = value["presentations"] as? Array<Dictionary<String, AnyObject>> ?? [Dictionary<String, AnyObject>]()
                
                do {
                    let realm = try Realm()
                    try realm.write({
                        presentations.forEach({
                            let talkObject = TalkObject(dictionary: $0)
                            realm.add(talkObject, update: true)
                        })
                    })
                    
                    completionHandler(.Success())
                } catch let error as NSError {
                    completionHandler(.Failure(error))
                }
            case .Failure(let error):
                completionHandler(.Failure(error))
            }
        }
    }
    
    func getTalksFromLocalDummyJson(completionHandler: (Result<Void, NSError> -> Void)) -> Void {
        let path = NSBundle.mainBundle().pathForResource("DummyTalks", ofType: "json")
        let fileHandle = NSFileHandle(forReadingAtPath: path!)
        let data = fileHandle?.readDataToEndOfFile()
        let dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! Dictionary<String, AnyObject>
        let presentations = dictionary["presentations"] as? Array<Dictionary<String, AnyObject>> ?? [Dictionary<String, AnyObject>]()
        
        do {
            let realm = try Realm()
            try realm.write({
                presentations.forEach({
                    let talkObject = TalkObject(dictionary: $0)
                    realm.add(talkObject, update: true)
                })
            })
            
            completionHandler(.Success())
        } catch let error as NSError {
            completionHandler(.Failure(error))
        }
        
    }
    
}
