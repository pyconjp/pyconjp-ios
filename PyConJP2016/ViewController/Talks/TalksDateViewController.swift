//
//  TalksDateViewController.swift
//  PyConJP2016
//
//  Created by 牟田　裕太郎 on 2016/02/22.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class TalksDateViewController: UIViewController {
    
    @IBOutlet weak var activeBarView: UIView!
    @IBOutlet weak var day1Button: UIButton!
    @IBOutlet weak var day2Button: UIButton!
    
    
    var activeBar = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: UIScreen.mainScreen().bounds.width / 2, height: 3)))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activeBar.backgroundColor = UIColor.redColor()
        activeBarView.addSubview(activeBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func didMoveToParentViewController(parent: UIViewController?) {
        let talksBaseViewController = parent as! TalksBaseViewController
        talksBaseViewController.addObserver(self, forKeyPath: "offsetToChange", options: [.New, .Old], context: nil)
        talksBaseViewController.addObserver(self, forKeyPath: "displayIndex", options: [.New, .Old], context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        print(change)
        switch keyPath! {
//        case "offsetToChange":
//            if let offsetToChange = change?["new"] as? CGFloat {
//                activeBar.frame.origin.x = offsetToChange / 2
//                print(activeBar.frame)
//            }
        case "displayIndex":
            if let displayIndex = change?["new"] as? Int {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.changeActive(displayIndex)
                })
            }
        default : break
        }
    }
    
    func changeActive(index: Int) {
        switch index {
        case 0:
            self.changeActiveButton(self.day1Button)
            self.changeUnactiveButton(self.day2Button)
            activeBarView.frame.origin.x = 0
        case 1:
            self.changeUnactiveButton(self.day1Button)
            self.changeActiveButton(self.day2Button)
            activeBarView.frame.origin.x = self.view.frame.width / 2
        default: break
        }
    }
    
    func changeActiveButton(button: UIButton) {
        button.backgroundColor = UIColor.whiteColor()
        button.titleLabel?.textColor = UIColor.blackColor()
//        button.enabled = false
    }
    
    func changeUnactiveButton(button: UIButton) {
        button.backgroundColor = UIColor.lightGrayColor()
        button.titleLabel?.textColor = UIColor.whiteColor()
//        button.enabled = true
    }
    
}
