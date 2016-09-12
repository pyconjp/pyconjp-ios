//
//  ConferenceListViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/07.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class ConferenceListViewController: UIViewController, UITableViewDelegate, TalksAPIType, ErrorAlertType {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib  = UINib(nibName: conferenceListDataSource.reuseIdentifier, bundle:nil)
            tableView.registerNib(nib, forCellReuseIdentifier: conferenceListDataSource.reuseIdentifier)
            
            refreshControl.addTarget(self, action: #selector(ConferenceListViewController.onRefresh(_:)), forControlEvents: .ValueChanged)
            tableView.addSubview(refreshControl)
            
            tableView.dataSource = conferenceListDataSource
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = TalkTableViewCell.estimatedRowHeight
        }
    }
    
    private(set) var viewControllerIndex: Int = 0
    private(set) var pyconJPDate: PyConJPDate?
    
    private lazy var conferenceListDataSource: ConferenceListDataSource = ConferenceListDataSource(day: self.pyconJPDate?.rawValue)
    
    private let refreshControl = UIRefreshControl()
    
    class func build(index: Int, storyboard: UIStoryboard, pyconJPDate: PyConJPDate) -> ConferenceListViewController {
        let conferenceListViewController = storyboard.instantiateViewControllerWithIdentifier("ConferenceListViewController") as! ConferenceListViewController
        conferenceListViewController.viewControllerIndex = index
        conferenceListViewController.pyconJPDate = pyconJPDate
        
        return conferenceListViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ConferenceListViewController.refreshNotification(_:)), name: PCJNotificationConfig.CompleteFetchDataNotification, object: nil)
        
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
        conferenceListDataSource.timelines.removeAll()
        tableView.reloadData()
        getTalks { [weak self](result) in
            guard let weakSelf = self else { return }
            switch result {
            case .Success:
                weakSelf.refresh()
            case .Failure(let error):
                weakSelf.refreshControl.endRefreshing()
                weakSelf.showErrorAlartWith(error, parent: weakSelf)
            }
        }
    }
    
    func refreshNotification(notification: NSNotification) {
        refresh()
    }
    
    func refresh() {
        conferenceListDataSource.refreshData { [weak self](result) in
            guard let weakSelf = self else { return }
            switch result {
            case .Success:
                dispatch_async(dispatch_get_main_queue()) {
                    weakSelf.tableView.reloadData()
                    if !weakSelf.conferenceListDataSource.timelines.isEmpty {
                        weakSelf.refreshControl.endRefreshing()
                    }
                }
            case .Failure: break
            }
        }

    }
    
    // MARK: - Table View Controller Delegate
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let talkObject = conferenceListDataSource.timelines[indexPath.section].talks[indexPath.row]
//        let talkDetailViewController = TalkDetailViewController.build(talkObject.id)
//        self.navigationController?.pushViewController(talkDetailViewController, animated: true)
        self.presentViewController(ScrollImageViewController.build(), animated: true, completion: nil)
    }
    
}
