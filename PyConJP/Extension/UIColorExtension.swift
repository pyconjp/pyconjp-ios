//
//  UIColorExtension.swift
//  PyConJP
//
//  Created by Yutaro Muta on 4/23/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func hex(string: NSString, alpha: CGFloat) -> UIColor {
        let hex = string.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hex)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red: r, green: g, blue: b, alpha: alpha)
        } else {
            print("invalid hex string")
            return UIColor.white
        }
    }
    
}

extension UIColor {
    
    static let navy: UIColor = UIColor(named: "navy")!
    
    static let goldenrod: UIColor = UIColor(named: "goldenrod")!
    
    static let crimson: UIColor = UIColor(named: "crimson")!
    
    static let lightYellow: UIColor = UIColor(named: "lightYellow")!
    
    static let silver: UIColor = UIColor(named: "silver")!
    
    static let davyGray: UIColor = UIColor(named: "davyGray")!
    
    static let twitter: UIColor = UIColor(named: "twitter")!
    
    static let facebook: UIColor = UIColor(named: "facebook")!
    
}
