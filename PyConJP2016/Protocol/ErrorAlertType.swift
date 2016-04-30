//
//  ErrorAlertType.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 4/23/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

protocol ErrorAlertType {
    
}

extension ErrorAlertType {
    func showErrorAlartWith(error: NSError, parent viewController: UIViewController) -> Void {
        let alert = UIAlertController(title: "hogehoge", message: "fugafuga", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
}
