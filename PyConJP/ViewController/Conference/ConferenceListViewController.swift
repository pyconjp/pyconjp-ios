//
//  ConferenceListViewController.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2016/03/07.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import APIKit

class ConferenceListViewController: UIViewController, ErrorAlertProtocol {
    
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
    
    fileprivate lazy var conferenceListDataSource: ConferenceListDataSource = ConferenceListDataSource(day: self.pyconJPDate?.description)
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(ConferenceListViewController.refreshNotification(_:)), name: NSNotification.Name(rawValue: PCJNotificationConfig.completeFetchDataNotification), object: nil)
        
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
        conferenceListDataSource.getTalksFromAPI { [weak self](result) in
            switch result {
            case .success:
                self?.refresh()
            case .failure(let error):
                self?.refreshControl.endRefreshing()
                guard let weakSelf = self else { return }
                DispatchQueue.main.async {
                    self?.showErrorAlart(with: error, parent: weakSelf)
                }
            }
        }
    }
    
    func refreshNotification(_ notification: Notification) {
        refresh()
    }
    
    func refresh() {
        conferenceListDataSource.refreshData { [weak self](result) in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
//                    if !(self?.conferenceListDataSource.timelines.isEmpty ?? false) {
                        self?.refreshControl.endRefreshing()
//                    }
                }
            case .failure(let error):
                self?.refreshControl.endRefreshing()
                guard let weakSelf = self else { return }
                DispatchQueue.main.async {
                    self?.showErrorAlart(with: error, parent: weakSelf)
                }
            }
        }

    }
    
}

extension ConferenceListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let talkObject = conferenceListDataSource.timelines[indexPath.section].talks[indexPath.row]
        let talkDetailViewController = TalkDetailViewController.build(id: talkObject.id)
        self.navigationController?.pushViewController(talkDetailViewController, animated: true)
    }
    
}
