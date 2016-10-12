//
//  TwitterURLSchemeProtocol.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 9/11/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import SafariServices

protocol TwitterURLSchemeProtocol {
    
    func openTwitter(userName: String, from viewController: UIViewController, alertBefore: Bool) -> Void
    func openTwitter(hashTag: String, from viewController: UIViewController, alertBefore: Bool) -> Void
    
}

extension TwitterURLSchemeProtocol {
    
    private var urlScheme: URL {
        return URL(string: "twitter://")!
    }
    
    private func openTwitterAppWithAlert(targetName: String, url: URL, from viewController: UIViewController) {
        let alertController = UIAlertController(title: NSLocalizedString("TwitterAlertTitle", tableName: "URLScheme", comment: ""),
                                                message: String(format: NSLocalizedString("TwitterAlertMessage", tableName: "URLScheme", comment: ""), arguments: [targetName]),
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Open", comment: ""), style: .default, handler: { action in
            UIApplication.shared.openURL(url)
        }))
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func openTwitter(userName: String, from viewController: UIViewController, alertBefore: Bool = false) -> Void {
        if UIApplication.shared.canOpenURL(urlScheme) {
            guard let url = URL(string: "twitter://user?screen_name=" + userName) else { return }
            if alertBefore {
                openTwitterAppWithAlert(targetName: "@\(userName)", url: url, from: viewController)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            guard let url = URL(string: "https://mobile.twitter.com/" + userName) else { return }
            let safariViewController = SFSafariViewController(url: url)
            viewController.present(safariViewController, animated: true, completion: nil)
        }
    }
    
    func openTwitter(hashTag: String, from viewController: UIViewController, alertBefore: Bool = false) -> Void {
        if UIApplication.shared.canOpenURL(urlScheme) {
            guard let url = URL(string: "twitter://search?query=%23" + hashTag) else { return }
            if alertBefore {
                openTwitterAppWithAlert(targetName: "#\(hashTag)", url: url, from: viewController)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            guard let url = URL(string: "https://mobile.twitter.com/search?q=%23" + hashTag + "&s=typd") else { return }
            let safariViewController = SFSafariViewController(url: url)
            viewController.present(safariViewController, animated: true, completion: nil)
        }
    }
    
}
