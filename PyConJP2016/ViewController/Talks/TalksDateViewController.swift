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
    var activeBar: UIView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: UIScreen.mainScreen().bounds.width / 2, height: 3)))

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
    }
}
