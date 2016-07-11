//
//  Language.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 7/11/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

enum Language: String {
    case JA = "ja"
    case EN = "en"
    
    var lang: String {
        switch self {
        case .JA:
            return "Japanese"
        case .EN:
            return "English"
        }
    }
}
