//
//  MailURLSchemeType.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 9/17/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

protocol MailURLSchemeType {
    
    func mailURLScheme(_ to: String, subject: String, body: String) -> URL?
    func openMail(_ to: String, subject: String, body: String)

}

extension MailURLSchemeType {
    
    fileprivate var urlScheme: URL {
        return URL(string: "mailto://")!
    }
    
}

extension MailURLSchemeType {
    
    func mailURLScheme(_ to: String, subject: String, body: String) -> URL? {
        if !UIApplication.shared.canOpenURL(urlScheme) { return nil }
        return URL(string: String(format: "mailto:%@?subject=%@&body=%@", arguments: [to, subject.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!, body.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!]))
    }
    
    func openMail(_ to: String, subject: String, body: String) {
        guard let url =  mailURLScheme(to, subject: subject, body: body) else { return }
        UIApplication.shared.openURL(url)
    }
    
}
