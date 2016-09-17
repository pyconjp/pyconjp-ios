//
//  MailURLSchemeType.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 9/17/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

protocol MailURLSchemeType {
    
    func mailURLScheme(to: String, subject: String, body: String) -> NSURL?
    func openMail(to: String, subject: String, body: String)

}

extension MailURLSchemeType {
    
    private var urlScheme: NSURL {
        return NSURL(string: "mailto://")!
    }
    
}

extension MailURLSchemeType {
    
    func mailURLScheme(to: String, subject: String, body: String) -> NSURL? {
        if !UIApplication.sharedApplication().canOpenURL(urlScheme) { return nil }
        return NSURL(string: String(format: "mailto:%@?subject=%@&body=%@", arguments: [to, subject.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet())!, body.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet())!]))
    }
    
    func openMail(to: String, subject: String, body: String) {
        guard let url =  mailURLScheme(to, subject: subject, body: body) else { return }
        UIApplication.sharedApplication().openURL(url)
    }
    
}
