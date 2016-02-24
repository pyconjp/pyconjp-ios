//
//  TalksPageViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/21.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class TalksPageViewController: UIPageViewController {
    
    var dayNumber: Int = 0
    var childrenViewControllers: Array<TalksListViewController> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.grayColor()
        
        let startingViewController: TalksListViewController = self.talksModelController.viewControllerAtIndex(0, storyboard: self.storyboard!)!
        let viewControllers = [startingViewController]
        self.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: {done in })
        
        self.dataSource = self.talksModelController

//        let talksStoryboard = UIStoryboard(name: "Talks", bundle: NSBundle.mainBundle())
//        let colorArray = [UIColor.redColor(), UIColor.purpleColor(), UIColor.yellowColor(), UIColor.grayColor()]
//        for i in 0...3 {
//            let talksListViewController = talksStoryboard.instantiateViewControllerWithIdentifier("TalksListViewController") as! TalksListViewController
//            talksListViewController.roomNumber = i
//            talksListViewController.view.backgroundColor = colorArray[i]
//            childrenViewControllers.append(talksListViewController)
//        }
//        
//        self.setViewControllers([childrenViewControllers[0]], direction: .Forward, animated: false, completion: nil)
        
    }
    
    var _talksModelController: TalksModelController? = nil
    
    var talksModelController: TalksModelController {
        if _talksModelController == nil {
            _talksModelController = TalksModelController()
        }
        return _talksModelController!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        let talksBaseViewController = parent as! TalksBaseViewController
        self.delegate = talksBaseViewController
    }
    
}
