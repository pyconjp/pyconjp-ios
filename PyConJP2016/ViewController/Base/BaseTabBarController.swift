//
//  BaseTabBarController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/19.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    private var conferenceTabNavigationController: UINavigationController?
    private var bookmarkTabNavigationController: UINavigationController?
    private var moreTabNavigationController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ConferenceTab
        let conferenceStoryboard = UIStoryboard(name: "Conference", bundle: NSBundle.mainBundle())
        conferenceTabNavigationController = conferenceStoryboard.instantiateViewControllerWithIdentifier("ConferenceNavigationController") as? UINavigationController
        
        //BookmarkTab
        let bookmarkStoryboard = UIStoryboard(name: "Bookmark", bundle: NSBundle.mainBundle())
        bookmarkTabNavigationController = bookmarkStoryboard.instantiateViewControllerWithIdentifier("BookmarkNavigationController") as? UINavigationController
        
        //MoreTab
        let moreStoryboard = UIStoryboard(name: "More", bundle: NSBundle.mainBundle())
        moreTabNavigationController = moreStoryboard.instantiateViewControllerWithIdentifier("MoreNavigationController") as? UINavigationController
        
        let viewControllers = [conferenceTabNavigationController!, bookmarkTabNavigationController!, moreTabNavigationController!] as [UIViewController]
        self.setViewControllers(viewControllers, animated: false)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
