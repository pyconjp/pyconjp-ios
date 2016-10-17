//
//  TalkDetailAPIProtocol.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 7/25/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import RealmSwift

protocol TalkDetailAPIProtocol: AlamofireProtocol {
    var id: Int? { get set }
    
    func getTalkDetail(successClosure success: @escaping (TalkDetail) -> Void, failClosure fail: @escaping (Error) -> Void) -> Void
    func getTalkDetail(completionHandler: @escaping ((Result<TalkDetail>) -> Void)) -> Void
    func getTalkDetailFromLocalDummyJson(completionHandler: ((Result<TalkDetail>) -> Void)) -> Void
}

extension TalkDetailAPIProtocol {
    
    var path: String {
        guard let id = id else { return "" }
        return "presentation/\(id)/"
    }
    
}

extension TalkDetailAPIProtocol {
    
    func getTalkDetail(successClosure success: @escaping (TalkDetail) -> Void, failClosure fail: @escaping (Error) -> Void) -> Void {
        get(successClosure: { dictionary in
            let talkDetail = TalkDetail(dictionary: dictionary)
            success(talkDetail)
            }, failureClosure: { error in
                fail(error)
        })
    }
    
    func getTalkDetail(completionHandler: @escaping ((Result<TalkDetail>) -> Void)) -> Void {
        get() { result in
            switch result {
            case .success(let value):
                let talkDetail = TalkDetail(dictionary: value)
                completionHandler(.success(talkDetail))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getTalkDetailFromLocalDummyJson(completionHandler: ((Result<TalkDetail>) -> Void)) -> Void {
        let path = Bundle.main.path(forResource: "DummyTalkDetail", ofType: "json")
        let fileHandle = FileHandle(forReadingAtPath: path!)
        let data = fileHandle?.readDataToEndOfFile()
        let dictionary = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String, AnyObject>
        
        let talkDetail = TalkDetail(dictionary: dictionary)
        completionHandler(.success(talkDetail))
        
    }
    
}
