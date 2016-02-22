//
//  TalksRootViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/21.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class TalksRootViewController: UIViewController {

    @IBOutlet weak var daySegmentedControl: UISegmentedControl!
    @IBOutlet weak var pageViewControllerContainerView: UIView!
    
    var pageViewControllers: [TalksPageViewController] = []
    var selectedDay: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0...1 {
            let talksPageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TalksPageViewController") as! TalksPageViewController
            talksPageViewController.dayNumber = i
            pageViewControllers.append(talksPageViewController)
        }
        
        self.addNewChildrenViewController(0)
        pageViewControllers[0].didMoveToParentViewController(self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentChange(sender: UISegmentedControl) {
        self.alterContainerView(selectedDay, new: sender.selectedSegmentIndex)
        selectedDay = sender.selectedSegmentIndex
    }
    
    func addNewChildrenViewController(new: Int) {
        self.addChildViewController(pageViewControllers[new])
        self.pageViewControllerContainerView.addSubview(pageViewControllers[new].view)
        pageViewControllers[new].view.frame = CGRectMake(0, 0, pageViewControllerContainerView.frame.width, pageViewControllerContainerView.frame.height)
    }
    
    func alterContainerView(old: Int, new: Int) {
        self.pageViewControllers[old].willMoveToParentViewController(nil)
        self.addNewChildrenViewController(new)
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.pageViewControllers[old].view.alpha = 0
            self.pageViewControllers[new].view.alpha = 1
            }) { (finished: Bool) -> Void in
                self.pageViewControllers[old].removeFromParentViewController()
                self.pageViewControllers[new].didMoveToParentViewController(self)
        }
    }

}
