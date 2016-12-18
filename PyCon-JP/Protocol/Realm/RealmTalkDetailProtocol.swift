//
//  RealmTalkDetailProtocol.swift
//  PyCon-JP
//
//  Created by Yutaro Muta on 2016/12/18.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

protocol RealmTalkDetailProtocol {
    func getTalksFromLocalDummyJson(completionHandler: ((Result<Void>) -> Void)) -> Void
}

extension RealmTalkDetailProtocol {
    
    func getTalkDetailFromLocalDummyJson(completionHandler: ((Result<TalkDetail>) -> Void)) -> Void {
        let path = Bundle.main.path(forResource: "DummyTalkDetail", ofType: "json")
        let fileHandle = FileHandle(forReadingAtPath: path!)
        let data = fileHandle?.readDataToEndOfFile()
        let dictionary = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String, Any>
        
        let talkDetail = TalkDetail(dictionary: dictionary)
        completionHandler(.success(talkDetail))
        
    }
    
}
