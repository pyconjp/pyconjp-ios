//
//  ConferenceListViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/07.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class ConferenceListViewController: UIViewController, UITableViewDelegate, TalksAPIProtocol, ErrorAlertProtocol {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib  = UINib(nibName: conferenceListDataSource.reuseIdentifier, bundle:nil)
            tableView.register(nib, forCellReuseIdentifier: conferenceListDataSource.reuseIdentifier)
            
            refreshControl.addTarget(self, action: #selector(ConferenceListViewController.onRefresh(_:)), for: .valueChanged)
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    class func build(at index: Int, storyboard: UIStoryboard, pyconJPDate: PyConJPDate) -> ConferenceListViewController {
        let conferenceListViewController = storyboard.instantiateViewController(withIdentifier: "ConferenceListViewController") as! ConferenceListViewController
        conferenceListViewController.viewControllerIndex = index
        conferenceListViewController.pyconJPDate = pyconJPDate
        
        return conferenceListViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ConferenceListViewController.refreshNotification(_:)), name: NSNotification.Name(rawValue: PCJNotificationConfig.CompleteFetchDataNotification), object: nil)
        
        refreshControl.beginRefreshing()
        refresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    
    func onRefresh(_ sender: UIRefreshControl) {
        conferenceListDataSource.timelines.removeAll()
        tableView.reloadData()
        getTalks { [weak self](result) in
            guard let weakSelf = self else { return }
            switch result {
            case .success:
                weakSelf.refresh()
            case .failure(let error):
                weakSelf.refreshControl.endRefreshing()
                weakSelf.showErrorAlart(with: error, parent: weakSelf)
            }
        }
    }
    
    func refreshNotification(_ notification: Notification) {
        refresh()
    }
    
    func refresh() {
        conferenceListDataSource.refreshData { [weak self](result) in
            guard let weakSelf = self else { return }
            switch result {
            case .success:
                DispatchQueue.main.async {
                    weakSelf.tableView.reloadData()
                    if !weakSelf.conferenceListDataSource.timelines.isEmpty {
                        weakSelf.refreshControl.endRefreshing()
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    weakSelf.showErrorAlart(with: error, parent: weakSelf)
                    weakSelf.refreshControl.endRefreshing()
                }
            }
        }

    }
    
    // MARK: - Table View Controller Delegate
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let talkObject = conferenceListDataSource.timelines[(indexPath as NSIndexPath).section].talks[(indexPath as NSIndexPath).row]
        let talkDetailViewController = TalkDetailViewController.build(id: talkObject.id)
        self.navigationController?.pushViewController(talkDetailViewController, animated: true)
    }
    
}
