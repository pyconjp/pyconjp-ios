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
    
    func openTwitterUser(userName: String, from viewController: UIViewController) -> Void
    func openTwitterHashTag(hashTag: String, from viewController: UIViewController) -> Void

}

extension TwitterURLSchemeType {
    
    private var urlScheme: NSURL {
        return NSURL(string: "twitter://")!
    }
    
}

extension TwitterURLSchemeType {
    
    func openTwitterUser(userName: String, from viewController: UIViewController) -> Void {
        if UIApplication.sharedApplication().canOpenURL(urlScheme) {
            guard let url = NSURL(string: "twitter://user?screen_name=" + userName) else { return }
            UIApplication.sharedApplication().openURL(url)
        } else {
            guard let url = NSURL(string: "https://mobile.twitter.com/" + userName) else { return }
            let safariViewController = SFSafariViewController(URL: url)
            viewController.presentViewController(safariViewController, animated: true, completion: nil)
        }
    }
    
    func openTwitterHashTag(hashTag: String, from viewController: UIViewController) -> Void {
        if UIApplication.sharedApplication().canOpenURL(urlScheme) {
            guard let url = NSURL(string: "twitter://search?query=%23" + hashTag) else { return }
            UIApplication.sharedApplication().openURL(url)
        } else {
            guard let url = NSURL(string: "https://mobile.twitter.com/search?q=%23" + hashTag + "&s=typd") else { return }
            let safariViewController = SFSafariViewController(URL: url)
            viewController.presentViewController(safariViewController, animated: true, completion: nil)
        }
    }
    
}
