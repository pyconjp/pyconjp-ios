//
//  UIColorExtension.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 4/23/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func hexStr(_ hexStr: NSString, alpha: CGFloat) -> UIColor {
        let hex = hexStr.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hex)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r, green:g, blue:b, alpha:alpha)
        } else {
            print("invalid hex string")
            return UIColor.white
        }
    }
    
    static func pyconJP2016RedColor() -> UIColor {
        return UIColor.hexStr("#EB6D9A", alpha: 1)
    }
    
    static func pyconJP2016OrangeColor() -> UIColor {
        return UIColor.hexStr("#F19975", alpha: 1)
    }
    
    static func pyconJP2016LightOrangeColor() -> UIColor {
        return UIColor.hexStr("#F8C058", alpha: 1)
    }
    
    static func pyconJP2016YellowColor() -> UIColor {
        return UIColor.hexStr("#FFE45F", alpha: 1)
    }
    
    static func pyconJP2016LightGreenColor() -> UIColor {
        return UIColor.hexStr("#A9C952", alpha: 1)
    }
    
    static func pyconJP2016GreenColor() -> UIColor {
        return UIColor.hexStr("#86C8A0", alpha: 1)
    }
    
    static func pyconJP2016BlueColor() -> UIColor {
        return UIColor.hexStr("#54C2F0", alpha: 1)
    }
    
    static func pyconJP2016GlayColor() -> UIColor {
        return UIColor.hexStr("#C8C8C8", alpha: 1)
    }
    
    static func twitterColor() -> UIColor {
        return UIColor.hexStr("#55ACEE", alpha: 1)
    }
    
    static func facebookColor() -> UIColor {
        return UIColor.hexStr("#315096", alpha: 1)
    }
    
}
