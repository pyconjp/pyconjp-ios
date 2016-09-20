//
//  NSLocaleExtension.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 8/16/2016.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

extension NSLocale {
    
    static var currentLanguageLocaleIdentifier: String {
        return NSBundle.mainBundle().preferredLocalizations.first!
    }
    
    static var currentLanguageLocale: NSLocale {
        return NSLocale(localeIdentifier: NSLocale.currentLanguageLocaleIdentifier)
    }
    
}
