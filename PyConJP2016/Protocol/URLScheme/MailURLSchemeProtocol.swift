//
//  MailURLSchemeProtocol.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 9/17/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

protocol MailURLSchemeProtocol {
    
    func mailURLScheme(to address: String, subject: String, body: String) -> URL?
    func openMail(to address: String, subject: String, body: String)

}

extension MailURLSchemeProtocol {
    
    private var urlScheme: URL {
        return URL(string: "mailto://")!
    }
    
    func mailURLScheme(to address: String, subject: String, body: String) -> URL? {
        if !UIApplication.shared.canOpenURL(urlScheme) { return nil }
        return URL(string: String(format: "mailto:%@?subject=%@&body=%@", arguments: [address, subject.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!, body.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!]))
    }
    
    func openMail(to address: String, subject: String, body: String) {
        guard let url =  mailURLScheme(to: address, subject: subject, body: body) else { return }
        UIApplication.shared.openURL(url)
    }
    
}
