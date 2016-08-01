//
//  AlamofireType.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 4/21/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit
import Alamofire

protocol AlamofireType {
    var alamofireManager: Alamofire.Manager { get }
    var baseURL: String { get }
    var path: String { get }
    var authUser: String { get }
    var authPassword: String { get }
    
    func get(parameter: Dictionary<String, AnyObject>?, successClosure success: (Dictionary<String, AnyObject>) -> Void, failClosure fail: (NSError) -> Void) -> Void
//    func post(url: String, parameter: Dictionary<String, AnyObject>?, successClosure success: () -> Void, failClosure fail: (NSError) -> Void) -> Void
}

extension AlamofireType {
    
    var alamofireManager: Alamofire.Manager {
        return Alamofire.Manager.sharedInstance
    }
    
    var baseURL: String {
        return NSProcessInfo.processInfo().environment["APIBaseURL"] ?? "https://pycon.jp/2016/ja/api/"
    }
    
    var authUser: String {
        return NSProcessInfo.processInfo().environment["APIAuthUser"] ?? ""
    }
    
    var authPassword: String {
        return NSProcessInfo.processInfo().environment["APIAuthPassword"] ?? ""
    }
    
    func get(parameter: Dictionary<String, AnyObject>?, successClosure success: (Dictionary<String, AnyObject>) -> Void, failClosure fail: (NSError) -> Void) -> Void {
        let url = baseURL + path
        let responseClosure = { (response: Response<AnyObject, NSError>) in
            switch response.result {
            case .Success:
                if let responseDicsionary = response.result.value as? Dictionary<String, AnyObject> {
                    success(responseDicsionary)
                }
            case .Failure(let error):
                fail(error)
            }
        }
        
        alamofireManager.request(.GET, url).authenticate(user: authUser, password: authPassword).responseJSON(completionHandler: responseClosure)

    }
    
}
