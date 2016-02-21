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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
