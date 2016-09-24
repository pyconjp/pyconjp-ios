//
//  BookmarkListViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/08/18.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class BookmarkListViewController: UIViewController, UITableViewDelegate, ErrorAlertType {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib  = UINib(nibName: bookmarkListDataSource.reuseIdentifier, bundle:nil)
            tableView.registerNib(nib, forCellReuseIdentifier: bookmarkListDataSource.reuseIdentifier)
            tableView.dataSource = bookmarkListDataSource
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = TalkTableViewCell.estimatedRowHeight
        }
    }
    
    private let bookmarkListDataSource = BookmarkListDataSource()
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    class func build() -> BookmarkListViewController {
        return UIStoryboard(name: "Bookmark", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("BookmarkListViewController") as! BookmarkListViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BookmarkListViewController.refreshNotification(_:)), name: PCJNotificationConfig.CompleteFetchDataNotification, object: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        
        refresh()
    }
    
    func refreshNotification(notification: NSNotification) {
        refresh()
    }
    
    func refresh() {
        bookmarkListDataSource.refreshData { [weak self](result) in
            guard let weakSelf = self else { return }
            switch result {
            case .Success:
                dispatch_async(dispatch_get_main_queue()) {
                    weakSelf.tableView.reloadData()
                }
            case .Failure(let error):
                dispatch_async(dispatch_get_main_queue()) {
                    weakSelf.showErrorAlartWith(error, parent: weakSelf)
                }
            }
        }

    }
    
    // MARK: - Table View Controller Delegate
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let talkObject = bookmarkListDataSource.timelines[indexPath.section].talks[indexPath.row]
        let talkDetailViewController = TalkDetailViewController.build(talkObject.id)
        self.navigationController?.pushViewController(talkDetailViewController, animated: true)
    }
    
}
