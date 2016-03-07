//
//  ScheduleListViewController.swift
//  PyConJP2016
//
//  Created by 牟田　裕太郎 on 2016/03/07.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class ScheduleListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewControllerIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib  = UINib(nibName: "ScheduleListTableViewCell", bundle:nil)
        tableView.registerNib(nib, forCellReuseIdentifier:"ScheduleListTableViewCell")
        
        tableView.estimatedRowHeight = 120
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //mark UITableViewDelegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ScheduleListTableViewCell") as? ScheduleListTableViewCell
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let talkDetailViewController = mainStoryboard.instantiateViewControllerWithIdentifier("TalkDetailViewController") as! TalkDetailViewController
        self.navigationController?.pushViewController(talkDetailViewController, animated: true)
    }
    
}
