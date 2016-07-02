//
//  UIColorExtension.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 4/23/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

extension UIColor {
    class func hexStr (hexStr: NSString, alpha: CGFloat) -> UIColor {
        let hex = hexStr.stringByReplacingOccurrencesOfString("#", withString: "") as String
        let scanner = NSScanner(string: hex)
        var color: UInt32 = 0
        if scanner.scanHexInt(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r, green:g, blue:b, alpha:alpha)
        } else {
            print("invalid hex string")
            return UIColor.whiteColor()
        }
    }
    
    class func pyconJP2016RedColor() -> UIColor {
        return UIColor.hexStr("#EB6D9A", alpha: 1)
    }
    
    class func pyconJP2016BlueColor() -> UIColor {
        return UIColor.hexStr("#54c2f0", alpha: 1)
    }
    
    class func pyconJP2016GreenColor() -> UIColor {
        return UIColor.hexStr("#a9c952", alpha: 1)
    }
    
    class func pyconJP2016GlayColor() -> UIColor {
        return UIColor.hexStr("#C8C8C8", alpha: 1)
    }
    
}
