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
    var host: String { get }
    func get(path: String, parameter: Dictionary<String, AnyObject>?, successClosure success: (Dictionary<String, AnyObject>) -> Void, failClosure fail: (NSError) -> Void) -> Void
//    func post(url: String, parameter: Dictionary<String, AnyObject>?, successClosure success: () -> Void, failClosure fail: (NSError) -> Void) -> Void
}

extension AlamofireType {
    
    var host: String {
//        #if STG
            return ""
//        #else
//            return "https://pycon.jp/2016/ja/api/"
//        #endif
    }
    
    func get(path: String, parameter: Dictionary<String, AnyObject>?, successClosure success: (Dictionary<String, AnyObject>) -> Void, failClosure fail: (NSError) -> Void) -> Void {
        let url = host + path
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
        #if STG
            Alamofire.request(.GET, url).authenticate(user: "", password: "").responseJSON(completionHandler: responseClosure)
        #else
            Alamofire.request(.GET, url, parameters: parameter).responseJSON(completionHandler: responseClosure)
        #endif
        
//        #if STG
//            Alamofire.request(.GET, url).authenticate(user: "", password: "").responseJSON { response in
//                switch response.result {
//                case .Success:
//                    if let responseDicsionary = response.result.value as? Dictionary<String, AnyObject> {
//                        success(responseDicsionary)
//                    }
//                case .Failure(let error):
//                    fail(error)
//                }
//            }
//        #else
//        Alamofire.request(.GET, url, parameters: parameter).responseJSON { response in
//            switch response.result {
//            case .Success:
//                if let responseDicsionary = response.result.value as? Dictionary<String, AnyObject> {
//                    success(responseDicsionary)
//                }
//            case .Failure(let error):
//                fail(error)
//            }
//        }
//        #endif
    }
}
