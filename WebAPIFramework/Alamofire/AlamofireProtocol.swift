//
//  AlamofireProtocol.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 4/21/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import Alamofire

public protocol AlamofireProtocol {
    var baseURL: String { get }
    var path: String { get }
    var authUser: String { get }
    var authPassword: String { get }
    
    func get(parameter: [String: Any]?, completionHandler: @escaping ((Result<[String: Any]>) -> Void)) -> Void
}

public extension AlamofireProtocol {
    
    var baseURL: String {
        return WebConfig.apiURL
    }
    
    var authUser: String {
        return WebConfig.authUser
    }
    
    var authPassword: String {
        return WebConfig.authPassword
    }
    
}

public extension AlamofireProtocol {
    
    func get(parameter: [String: Any]? = nil, completionHandler: @escaping ((Result<[String: Any]>) -> Void)) -> Void {
        let url = baseURL + path
        let responseClosure = { (response: DataResponse<Any>) in
            switch response.result {
            case .success(let value):
                if let responseDicsionary = value as? [String: Any] {
                    completionHandler(.success(responseDicsionary))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
        
        Alamofire.request(url, method: .get, parameters: parameter).authenticate(user: authUser, password: authPassword).responseJSON(completionHandler: responseClosure)
    }
    
}
