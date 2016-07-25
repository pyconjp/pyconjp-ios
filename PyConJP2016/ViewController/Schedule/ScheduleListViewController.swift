//
//  ScheduleListViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/07.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class ScheduleListViewController: UIViewController, UITableViewDelegate, ErrorAlertType {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewControllerIndex: Int = 0
    var day: String = ""
    
    let scheduleListDataSource = ScheduleListDataSource()
    
    let refreshControl = UIRefreshControl()
    
    let reuseIdentifier = "ScheduleListTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ScheduleListViewController.onRefresh(_:)), name: AppConfig.PCJCompleteFetchDataNotification, object: nil)
        
        let nib  = UINib(nibName: "ScheduleListTableViewCell", bundle:nil)
        tableView.registerNib(nib, forCellReuseIdentifier:reuseIdentifier)
        
        refreshControl.addTarget(self, action: #selector(ScheduleListViewController.onRefresh(_:)), forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)
        
        tableView.dataSource = scheduleListDataSource
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        refreshControl.beginRefreshing()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        
    }
    
    func onRefresh(sender: UIRefreshControl) {
        scheduleListDataSource.refreshData(day)
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Table View Controller Delegate
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let talkDetailViewController = TalkDetailViewController.build()
        talkDetailViewController.id = scheduleListDataSource.timelines[indexPath.section].talks[indexPath.row].id
        self.navigationController?.pushViewController(talkDetailViewController, animated: true)
    }
    
}
