//
//  ScheduleDateViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/07.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class ScheduleDateViewController: UIViewController, ScheduleDateViewProtocol {
    
    @IBOutlet weak var activeBar: UIView!
    @IBOutlet weak var day1Button: UIButton!
    @IBOutlet weak var day2Button: UIButton!
    
    var buttonOriginXArray: [CGFloat] = []
    
    var schedulePageViewProtocol: SchedulePageViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        if buttonOriginXArray.count == 0 {
            self.createButtonOriginXArray()
        }
    }
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        guard let scheduleBaseViewController = parent as? ScheduleBaseViewController else { return }
        scheduleBaseViewController.scheduleDateViewProtocol = self
        schedulePageViewProtocol = scheduleBaseViewController.schedulePageViewProtocol
        
    }
    
    func createButtonOriginXArray() {
        self.view.subviews.forEach {
            if let button = $0 as? UIButton {
                buttonOriginXArray.append(button.frame.origin.x)
            }
        }
    }
    
    // MARK: - Day Button
    
    @IBAction func onDay1Button(sender: UIButton) {
        if let schedulePageViewProtocol = schedulePageViewProtocol {
            schedulePageViewProtocol.reversePage(0)
            changeActive(0)
        }
    }
    
    @IBAction func onDay2Button(sender: UIButton) {
        if let schedulePageViewProtocol = schedulePageViewProtocol {
            schedulePageViewProtocol.fowardPage(1)
            changeActive(1)
        }
    }
    
    // MARK: - ScheduleDateViewProtocol
    
    func changeActive(index: Int) {
        
        func changeActiveButton(button: UIButton) {
            button.enabled = false
            button.backgroundColor = .whiteColor()
            button.setTitleColor(.blackColor(), forState: .Normal)
        }
        
        func changeUnactiveButton(button: UIButton) {
            button.enabled = true
            button.backgroundColor = .pyconJP2016GlayColor()
            button.setTitleColor(.whiteColor(), forState: .Normal)
        }
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.activeBar.frame.origin.x = self.buttonOriginXArray[index]
            switch index {
            case 0:
                changeActiveButton(self.day1Button)
                changeUnactiveButton(self.day2Button)
            case 1:
                changeUnactiveButton(self.day1Button)
                changeActiveButton(self.day2Button)
            default:
                break
            }
        })
    }
    
}
