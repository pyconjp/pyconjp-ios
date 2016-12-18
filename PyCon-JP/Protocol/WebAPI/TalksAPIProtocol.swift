//
//  TalksAPIProtocol.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 4/23/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import WebAPIFramework
import RealmSwift

protocol TalksAPIProtocol: AlamofireProtocol {
    func getTalks(completionHandler: @escaping ((Result<Void>) -> Void)) -> Void
}

extension TalksAPIProtocol {
    
    var path: String {
        return "talks/list/"
    }
    
}

extension TalksAPIProtocol {
    
    func getTalks(completionHandler: @escaping ((Result<Void>) -> Void)) -> Void {
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
    
}
