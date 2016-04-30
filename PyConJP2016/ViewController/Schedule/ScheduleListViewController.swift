//
//  ScheduleListViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/07.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class ScheduleListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TalkAPIType, ErrorAlertType {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewControllerIndex: Int = 0
    var date: String = ""
    
    let reuseIdentifier = "ScheduleListTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib  = UINib(nibName: "ScheduleListTableViewCell", bundle:nil)
        tableView.registerNib(nib, forCellReuseIdentifier:reuseIdentifier)
        
        tableView.estimatedRowHeight = 120
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        weak var weakSelf = self
        
        getTalksWithParameter(["day": viewControllerIndex], successClosure: { _ in
            dispatch_async(dispatch_get_main_queue(), { 
                weakSelf!.tableView.reloadData()
            })
            }) { error in
//                let alert = UIAlertController(title: "hogehoge", message: "fugafuga", preferredStyle: .Alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
//                weakSelf?.presentViewController(alert, animated: true, completion: nil)
                self.showErrorAlartWith(error, parent: weakSelf!);
        }
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Table View Controller Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "10:00~"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as? ScheduleListTableViewCell else {
            fatalError("Could not create ScheduleListTableViewCell")
        }
        return cell
    }
    
    // MARK: - Table View Controller Delegate
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let talkDetailViewController = mainStoryboard.instantiateViewControllerWithIdentifier("TalkDetailViewController") as! TalkDetailViewController
        self.navigationController?.pushViewController(talkDetailViewController, animated: true)
    }
    
}
