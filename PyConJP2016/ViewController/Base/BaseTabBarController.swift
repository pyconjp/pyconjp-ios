//
//  BaseTabBarController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/19.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    var talksTabNavigationController: UINavigationController?
    var moreTabNavigationController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TalkTab
        let talkStoryboard = UIStoryboard(name: "Talks", bundle: NSBundle.mainBundle())
        self.talksTabNavigationController = talkStoryboard.instantiateViewControllerWithIdentifier("TalksNavigationController") as? UINavigationController
        
        //MoreTab
        let moreStoryboard = UIStoryboard(name: "More", bundle: NSBundle.mainBundle())
        self.moreTabNavigationController = moreStoryboard.instantiateViewControllerWithIdentifier("MoreNavigationController") as? UINavigationController
        
        let viewControllers = [talksTabNavigationController!, moreTabNavigationController!] as [UIViewController]
        self.setViewControllers(viewControllers, animated: false)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
