//
//  ErrorAlertType.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 4/23/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

protocol ErrorAlertType {
    func showErrorAlartWith(error: NSError, parent viewController: UIViewController?) -> Void
}

extension ErrorAlertType {
    func showErrorAlartWith(error: NSError, parent viewController: UIViewController? = nil) -> Void {
        
        let rootViewController = viewController != nil ? viewController! : UIApplication.sharedApplication().keyWindow!.rootViewController!
        
        let alert = UIAlertController(title: error.localizedFailureReason, message: error.localizedRecoverySuggestion, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        rootViewController.presentViewController(alert, animated: true, completion: nil)
    }
}
