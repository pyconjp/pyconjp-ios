//
//  AppDelegateExtention.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/15.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

extension AppDelegate {
    
    func showAlert(alertController: UIAlertController) {
        self.window?.rootViewController?.presentingViewController?.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func openTalkDetailViewController() {
        let talkDetailViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("TalkDetailViewController") as! TalkDetailViewController
        talkDetailViewController.talkDetail = nil
        self.window?.rootViewController?.presentedViewController?.navigationController?.pushViewController(talkDetailViewController, animated: true)
    }
    
}
