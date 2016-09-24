//
//  StaffListAPIType.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 9/10/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

protocol StaffListAPIType: AlamofireType {
    
    func getStaffs(completionHandler: (Result<Array<Staff>, NSError> -> Void)) -> Void
}

extension StaffListAPIType {
    
    var baseURL: String {
        return "https://pyconjp.github.io/"
    }
    
    var path: String {
        return "pyconjp-android/stafflist.json"
    }
    
}

extension StaffListAPIType {
    
    func getStaffs(completionHandler: (Result<Array<Staff>, NSError> -> Void)) -> Void {
        get() { result in
            switch result {
            case .Success(let value):
                let staffList = value["staffList"] as? Array<Dictionary<String, AnyObject>> ?? []
                completionHandler(.Success(staffList.map({ Staff(dictionary: $0) })))
            case .Failure(let error):
                completionHandler(.Failure(error))
            }
        
        }
    }
    
}
