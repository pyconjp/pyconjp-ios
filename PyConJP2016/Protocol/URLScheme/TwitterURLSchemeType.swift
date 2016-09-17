//
//  TwitterURLSchemeType.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 9/11/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import SafariServices

protocol TwitterURLSchemeType {
    
    func openTwitterUser(userName: String, from viewController: UIViewController, alertBefore: Bool) -> Void
    func openTwitterHashTag(hashTag: String, from viewController: UIViewController, alertBefore: Bool) -> Void

}

extension TwitterURLSchemeType {
    
    private var urlScheme: NSURL {
        return NSURL(string: "twitter://")!
    }
    
}

extension TwitterURLSchemeType {
    
    private func openTwitterAppWithAlert(targetName: String, url: NSURL, from viewController: UIViewController) {
        let alertController = UIAlertController(title: NSLocalizedString("TwitterAlertTitle", tableName: "URLScheme", comment: ""),
                                                message: String(format: NSLocalizedString("TwitterAlertMessage", tableName: "URLScheme", comment: ""), arguments: [targetName]),
                                                preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Open", comment: ""), style: .Default, handler: { action in
            UIApplication.sharedApplication().openURL(url)
        }))
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .Cancel, handler: nil))
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
    
}

extension TwitterURLSchemeType {
    
    func openTwitterUser(userName: String, from viewController: UIViewController, alertBefore: Bool = false) -> Void {
        if UIApplication.sharedApplication().canOpenURL(urlScheme) {
            guard let url = NSURL(string: "twitter://user?screen_name=" + userName) else { return }
            if alertBefore {
                openTwitterAppWithAlert("@\(userName)", url: url, from: viewController)
            } else {
                UIApplication.sharedApplication().openURL(url)
            }
        } else {
            guard let url = NSURL(string: "https://mobile.twitter.com/" + userName) else { return }
            let safariViewController = SFSafariViewController(URL: url)
            viewController.presentViewController(safariViewController, animated: true, completion: nil)
        }
    }
    
    func openTwitterHashTag(hashTag: String, from viewController: UIViewController, alertBefore: Bool = false) -> Void {
        if UIApplication.sharedApplication().canOpenURL(urlScheme) {
            guard let url = NSURL(string: "twitter://search?query=%23" + hashTag) else { return }
            if alertBefore {
                openTwitterAppWithAlert("#\(hashTag)", url: url, from: viewController)
            } else {
                UIApplication.sharedApplication().openURL(url)
            }
        } else {
            guard let url = NSURL(string: "https://mobile.twitter.com/search?q=%23" + hashTag + "&s=typd") else { return }
            let safariViewController = SFSafariViewController(URL: url)
            viewController.presentViewController(safariViewController, animated: true, completion: nil)
        }
    }
    
}
