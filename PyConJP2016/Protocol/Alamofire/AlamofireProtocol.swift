//
//  AlamofireProtocol.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 4/21/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import Alamofire

protocol AlamofireProtocol {
    var baseURL: String { get }
    var path: String { get }
    var authUser: String { get }
    var authPassword: String { get }
    
    func get(parameter: Dictionary<String, AnyObject>?, successClosure success: @escaping (Dictionary<String, AnyObject>) -> Void, failureClosure fail: @escaping (Error) -> Void) -> Void
    func get(parameter: Dictionary<String, AnyObject>?, completionHandler: @escaping ((Result<Dictionary<String, AnyObject>>) -> Void)) -> Void
}

extension AlamofireProtocol {
    
    var baseURL: String {
        return PCJConfig.apiURL
    }
    
    var authUser: String {
        return PCJConfig.authUser
    }
    
    var authPassword: String {
        return PCJConfig.authPassword
    }
    
}

extension AlamofireProtocol {
    
    func get(parameter: Dictionary<String, AnyObject>? = nil, successClosure success: @escaping (Dictionary<String, AnyObject>) -> Void, failureClosure fail: @escaping (Error) -> Void) -> Void {
        let url = baseURL + path
        let responseClosure = { (response: DataResponse<Any>) in
            switch response.result {
            case .success(let value):
                if let responseDicsionary = value as? Dictionary<String, AnyObject> {
                    success(responseDicsionary)
                }
            case .failure(let error):
                fail(error)
            }
        }
        
        Alamofire.request(url, method: .get, parameters: parameter).authenticate(user: authUser, password: authPassword).responseJSON(completionHandler: responseClosure)
    }
    
    func get(parameter: Dictionary<String, AnyObject>? = nil, completionHandler: @escaping ((Result<Dictionary<String, AnyObject>>) -> Void)) -> Void {
        let url = baseURL + path
        let responseClosure = { (response: DataResponse<Any>) in
            switch response.result {
            case .success(let value):
                if let responseDicsionary = value as? Dictionary<String, AnyObject> {
                    completionHandler(.success(responseDicsionary))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
        
        Alamofire.request(url, method: .get, parameters: parameter).authenticate(user: authUser, password: authPassword).responseJSON(completionHandler: responseClosure)
    }
    
}
