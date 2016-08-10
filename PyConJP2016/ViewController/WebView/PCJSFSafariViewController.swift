//
//  PCJSFSafariViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 7/31/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit
import SafariServices

class PCJSFSafariViewController: UIViewController, SFSafariViewControllerDelegate {
    
    private var url: String = ""
    
    //    class func build(url: String) -> PCJSFSafariViewController {
    //        let pcjSFSafariViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("PCJSFSafariViewController") as! PCJSFSafariViewController
    //        pcjSFSafariViewController.url = url
    //        return pcjSFSafariViewController
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let safariViewController = SFSafariViewController(URL: NSURL(string: url)!)
        safariViewController.delegate = self
        presentViewController(safariViewController, animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
