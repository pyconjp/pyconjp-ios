//
//  TalksBaseViewController.swift
//  PyConJP2016
//
//  Created by 牟田　裕太郎 on 2016/02/22.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class TalksBaseViewController: UIViewController {
        
    @IBOutlet weak var daySegmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
        
    
    var containerViewControllers: [TalksRootViewController] = []
    var selectedDay: Int = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colorArray = [UIColor.yellowColor(), UIColor.greenColor()]
            
        for i in 0...1 {
            let talksRootViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TalksRootViewController") as! TalksRootViewController
            talksRootViewController.dayNumber = i
            talksRootViewController.view.backgroundColor = colorArray[i]
            containerViewControllers.append(talksRootViewController)
        }
            
        self.addNewChildrenViewController(0)
        containerViewControllers[0].didMoveToParentViewController(self)
            
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
    @IBAction func segmentChange(sender: UISegmentedControl) {
        self.alterContainerView(selectedDay, new: sender.selectedSegmentIndex)
        selectedDay = sender.selectedSegmentIndex
    }
        
    func addNewChildrenViewController(new: Int) {
        self.addChildViewController(containerViewControllers[new])
        self.containerView.addSubview(containerViewControllers[new].view)
        containerViewControllers[new].view.frame = CGRectMake(0, 0, containerView.frame.width, containerView.frame.height)
    }
    
    func alterContainerView(old: Int, new: Int) {
        self.containerViewControllers[old].willMoveToParentViewController(nil)
        self.addNewChildrenViewController(new)
        self.containerViewControllers[new].view.alpha = 0
            
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.containerViewControllers[old].view.alpha = 0
            self.containerViewControllers[new].view.alpha = 1
            }) { (finished: Bool) -> Void in
                self.containerViewControllers[old].removeFromParentViewController()
                self.containerViewControllers[new].didMoveToParentViewController(self)
        }
    }
        
}

