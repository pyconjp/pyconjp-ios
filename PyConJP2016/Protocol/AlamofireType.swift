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
    func getWithParameter(url: String, parameter: [String : AnyObject], successClosure success: (NSDictionary) -> Void, failClosure fail: (NSError) -> Void) -> Void
//    func postWithParameter(parameter: [String : AnyObject], successClosure success: () -> Void, failClosure fail: (NSError) -> Void) -> Void
}

extension AlamofireType {
    func getWithParameter(url: String, parameter: [String : AnyObject], successClosure success: (NSDictionary) -> Void, failClosure fail: (NSError) -> Void) -> Void {
        Alamofire.request(.GET, url, parameters: parameter).responseJSON { response in
            switch response.result {
            case .Success:
                if let responseDicsionary = response.result.value as? NSDictionary {
                    success(responseDicsionary)
                }
            case .Failure(let error):
                fail(error)
            }
        }
    }
}
