//
//  BaseTabBarController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/19.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    var talksNavigationController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TabBar
        let talkStoryboard = UIStoryboard(name: "Talks", bundle: NSBundle.mainBundle())
        self.talksNavigationController = talkStoryboard.instantiateViewControllerWithIdentifier("TalksNavigationController") as? UINavigationController
        
        self.setViewControllers(NSArray(objects: talksNavigationController!) as? [UIViewController], animated: false)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
