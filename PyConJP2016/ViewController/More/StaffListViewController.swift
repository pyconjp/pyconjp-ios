//
//  StaffListViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 9/10/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import SafariServices

class StaffListViewController: UIViewController, TwitterType, ErrorAlertType {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib  = UINib(nibName: staffListDataSource.reuseIdentifier, bundle:nil)
            tableView.registerNib(nib, forCellReuseIdentifier: staffListDataSource.reuseIdentifier)
            
            refreshControl.addTarget(self, action: #selector(StaffListViewController.onRefresh(_:)), forControlEvents: .ValueChanged)
            tableView.addSubview(refreshControl)
            
            tableView.dataSource = staffListDataSource
            tableView.rowHeight = StaffTableViewCell.estimatedRowHeight
        }
    }

    private lazy var staffListDataSource: StaffListDataSource = StaffListDataSource(facebookAction: { (url) -> (() -> Void) in { self.facebookAction(url) } }, twitterAction: { (url) -> (() -> Void) in { self.twitterAction(url) } })
    
    private let refreshControl = UIRefreshControl()
    
    static func build() -> StaffListViewController {
        return UIStoryboard(name: "More", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("StaffListViewController") as! StaffListViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        refresh()
    }
    
    func refresh() {
        staffListDataSource.refreshData { result in
            switch result {
            case .Success:
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            case .Failure(let error):
                dispatch_async(dispatch_get_main_queue(), {
                    self.showErrorAlartWith(error, parent: self)
                    self.refreshControl.endRefreshing()
                })
            }
        }
    }
    
    // MARK: - StaffTableViewCell Button Action
    
    private func facebookAction(urlString: String) {
        guard let url = NSURL(string: urlString) else { return }
        let safariViewController = SFSafariViewController(URL: url)
        self.presentViewController(safariViewController, animated: true, completion: nil)
    }
    
    private func twitterAction(urlString: String) {
        let userName = urlString.stringByReplacingOccurrencesOfString("https://twitter.com/", withString: "")
        openTwitterUser(userName, from: self)
    }
    
}
