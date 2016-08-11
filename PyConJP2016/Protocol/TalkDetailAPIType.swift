//
//  TalkDetailAPIType.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 7/25/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import RealmSwift

protocol TalkDetailAPIType: AlamofireType {
    var id: Int? { get set }
    
    func getTalkDetail(successClosure success: (TalkDetail) -> Void, failClosure fail: (NSError) -> Void) -> Void
    func getTalkDetail(completionHandler: (Result<TalkDetail, NSError> -> Void)) -> Void
    func getTalkDetailFromLocalDummyJson(completionHandler: (Result<TalkDetail, NSError> -> Void)) -> Void
}

extension TalkDetailAPIType {
    
    var path: String {
        guard let id = id else { return "" }
        return "presentation/\(id)/"
    }
    
}

extension TalkDetailAPIType {
    
    func getTalkDetail(successClosure success: (TalkDetail) -> Void, failClosure fail: (NSError) -> Void) -> Void {
        get(successClosure: { dictionary in
            let talkDetail = TalkDetail(dictionary: dictionary)
            success(talkDetail)
            }, failClosure: { error in
                fail(error)
        })
    }
    
    func getTalkDetail(completionHandler: (Result<TalkDetail, NSError> -> Void)) -> Void {
        get() { result in
            switch result {
            case .Success(let value):
                let talkDetail = TalkDetail(dictionary: value)
                completionHandler(.Success(talkDetail))
            case .Failure(let error):
                completionHandler(.Failure(error))
            }
        }
    }
    
    func getTalkDetailFromLocalDummyJson(completionHandler: (Result<TalkDetail, NSError> -> Void)) -> Void {
        let path = NSBundle.mainBundle().pathForResource("DummyTalkDetail", ofType: "json")
        let fileHandle = NSFileHandle(forReadingAtPath: path!)
        let data = fileHandle?.readDataToEndOfFile()
        let dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! Dictionary<String, AnyObject>
        
        let talkDetail = TalkDetail(dictionary: dictionary)
        completionHandler(.Success(talkDetail))
        
    }
    
}
