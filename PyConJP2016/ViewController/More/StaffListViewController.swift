//
//  StaffListViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 9/10/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import SafariServices

class StaffListViewController: UIViewController, TwitterURLSchemeProtocol, ErrorAlertProtocol {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib  = UINib(nibName: staffListDataSource.reuseIdentifier, bundle:nil)
            tableView.register(nib, forCellReuseIdentifier: staffListDataSource.reuseIdentifier)
            
            refreshControl.addTarget(self, action: #selector(StaffListViewController.onRefresh(_:)), for: .valueChanged)
            tableView.addSubview(refreshControl)
            
            tableView.dataSource = staffListDataSource
            tableView.rowHeight = StaffTableViewCell.estimatedRowHeight
        }
    }

    private lazy var staffListDataSource: StaffListDataSource = StaffListDataSource(facebookAction: { (url) -> (() -> Void) in { self.facebookAction(urlString: url) } }, twitterAction: { (url) -> (() -> Void) in { self.twitterAction(urlString: url) } })
    
    private let refreshControl = UIRefreshControl()
    
    static func build() -> StaffListViewController {
        return UIStoryboard(name: "More", bundle: Bundle.main).instantiateViewController(withIdentifier: "StaffListViewController") as! StaffListViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        refresh()
    }
    
    func refresh() {
        staffListDataSource.refreshData { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            case .failure(let error):
                DispatchQueue.main.async(execute: {
                    self.showErrorAlart(with: error, parent: self)
                    self.refreshControl.endRefreshing()
                })
            }
        }
    }
    
    // MARK: - StaffTableViewCell Button Action
    
    private func facebookAction(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let safariViewController = SFSafariViewController(url: url)
        self.present(safariViewController, animated: true, completion: nil)
    }
    
    private func twitterAction(urlString: String) {
        let userName = urlString.replacingOccurrences(of: "https://twitter.com/", with: "")
        openTwitter(userName: userName, from: self)
    }
    
}
