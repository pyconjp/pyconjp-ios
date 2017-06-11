//
//  NibInstantitable.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/06/01.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import UIKit

protocol NibInstantitable {}

extension NibInstantitable {
    
    static var nibName: String {
        return String(describing: Self.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: Self.nibName, bundle: nil)
    }
    
    static func instantiateFromNib() -> Self {
        return nib.instantiate(withOwner: self, options: nil)[0] as! Self
    }
    
}
