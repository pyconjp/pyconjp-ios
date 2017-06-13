//
//  ErrorAlertProtocol.swift
//  PyConJP
//
//  Created by Yutaro Muta on 4/23/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

protocol ErrorAlertProtocol {
    func showErrorAlart(with error: Error, parent viewController: UIViewController?)
}

extension ErrorAlertProtocol {
    
    func showErrorAlart(with error: Error, parent viewController: UIViewController? = nil) {
        
        let rootViewController = viewController != nil ? viewController! : UIApplication.shared.keyWindow!.rootViewController!
        
        let alert = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        rootViewController.present(alert, animated: true, completion: nil)
    }
    
}
