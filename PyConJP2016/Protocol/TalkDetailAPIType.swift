//
//  TalkDetailAPIType.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 7/25/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit
import RealmSwift

protocol TalkDetailAPIType: AlamofireType {
    var id: Int? { get set }
    
    func getTalkDetail(successClosure success: (TalkDetail) -> Void, failClosure fail: (NSError) -> Void)
    func getTalkDetailFromLocalDummyJson(successClosure success: (TalkDetail) -> Void, failClosure fail: (NSError) -> Void)
}

extension TalkDetailAPIType {
    
    var path: String {
        guard let id = id else { return "" }
        return "presentation/\(id)/"
    }
    
    func getTalkDetail(successClosure success: (TalkDetail) -> Void, failClosure fail: (NSError) -> Void) {
        get(nil, successClosure: { dictionary in
            let talkDetail = TalkDetail(dictionary: dictionary)
            success(talkDetail)
            }, failClosure: { error in
                fail(error)
        })
    }
    
    func getTalkDetailFromLocalDummyJson(successClosure success: (TalkDetail) -> Void, failClosure fail: (NSError) -> Void) {
        let path = NSBundle.mainBundle().pathForResource("DummyTalkDetail", ofType: "json")
        let fileHandle = NSFileHandle(forReadingAtPath: path!)
        let data = fileHandle?.readDataToEndOfFile()
        let dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! Dictionary<String, AnyObject>
        
        let talkDetail = TalkDetail(dictionary: dictionary)
        success(talkDetail)
        
    }
    
}
