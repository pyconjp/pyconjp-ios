//
//  Language.swift
//  PyConJP
//
//  Created by Yutaro Muta on 7/11/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import Foundation

enum Language: CustomStringConvertible {
    case en
    case ja
    
    var description: String {
        switch self {
        case .en:
            return "en"
        case .ja:
            return "ja"
        }
    }
    
    var localized: String {
        switch self {
        case .en:
            return NSLocalizedString("English", tableName: "Language", comment: "")
        case .ja:
            return NSLocalizedString("Japanese", tableName: "Language", comment: "")
            
        }
    }
    
    init?(_ string: String) {
        switch string {
        case Language.en.description:
            self = .en
        case Language.ja.description:
            self = .ja
        default:
            return nil
        }
    }
}
