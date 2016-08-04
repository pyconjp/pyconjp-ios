//
//  ScheduleListViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/07.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class ScheduleListViewController: UIViewController, UITableViewDelegate, TalksAPIType, ErrorAlertType {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewControllerIndex: Int = 0
    var pyconJPDate: PyConJPDate?
    
    let scheduleListDataSource = ScheduleListDataSource()
    
    let refreshControl = UIRefreshControl()
    
    let reuseIdentifier = "ScheduleListTableViewCell"
    
    class func build(index: Int,storyboard: UIStoryboard, pyconJPDate: PyConJPDate) -> ScheduleListViewController {
        let scheduleListViewController = storyboard.instantiateViewControllerWithIdentifier("ScheduleListViewController") as! ScheduleListViewController
        scheduleListViewController.viewControllerIndex = index
        scheduleListViewController.pyconJPDate = pyconJPDate

        return scheduleListViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ScheduleListViewController.refreshNotification(_:)), name: AppConfig.PCJCompleteFetchDataNotification, object: nil)
        
        let nib  = UINib(nibName: "ScheduleListTableViewCell", bundle:nil)
        tableView.registerNib(nib, forCellReuseIdentifier:reuseIdentifier)
        
        refreshControl.addTarget(self, action: #selector(ScheduleListViewController.onRefresh(_:)), forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)
        
        tableView.dataSource = scheduleListDataSource
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        refreshControl.beginRefreshing()
        refresh()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        
    }
    
    func onRefresh(sender: UIRefreshControl) {
        scheduleListDataSource.timelines = []
        tableView.reloadData()
        getTalks(successClosure: { [weak self]() in
            self?.refresh()
        }) { [weak self](error) in
            guard let weakSelf = self else { return }
            weakSelf.showErrorAlartWith(error, parent: weakSelf)
        }
    }
    
    func refreshNotification(notification: NSNotification) {
        refresh()
    }
    
    func refresh() {
        guard let pyconJPDate = pyconJPDate else { return }
        scheduleListDataSource.refreshData(pyconJPDate)
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
            if !self.scheduleListDataSource.timelines.isEmpty {
                self.refreshControl.endRefreshing()
            }
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
