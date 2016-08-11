//
//  Result.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/08/10.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import Foundation

enum Result<T, Error: ErrorType> {
    case Success(T)
    case Failure(Error)
    
    var isSuccess: Bool {
        switch self {
        case .Success:
            return true
        case .Failure:
            return false
        }
    }
    
    var isFailure: Bool {
        return !isSuccess
    }
    
    var value: T? {
        switch self {
        case .Success(let value):
            return value
        case .Failure:
            return nil
        }
    }
    
    var error: Error? {
        switch self {
        case .Success:
            return nil
        case .Failure(let error):
            return error
        }
    }
    
}
