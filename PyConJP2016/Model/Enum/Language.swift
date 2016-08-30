//
//  Language.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 7/11/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

enum Language: String {
    case En = "en"
    case Ja = "ja"
    
    
    var localized: String {
        switch self {
        case .En: return "English"
        case .Ja: return "Japanese"
            
        }
    }
}
