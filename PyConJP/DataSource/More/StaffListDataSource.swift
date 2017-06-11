//
//  StaffListDataSource.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 9/10/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import APIKit
import Result

class StaffListDataSource: NSObject {
    
    let reuseIdentifier = "StaffTableViewCell"
    
    var teams: [Team] = []
    
    let facebookAction: ((_ url: String) -> (() -> Void))
    let twitterAction: ((_ url: String) -> (() -> Void))
    
    init(facebookAction: @escaping ((_ url: String) -> (() -> Void)), twitterAction: @escaping ((_ url: String) -> (() -> Void))) {
        self.facebookAction = facebookAction
        self.twitterAction = twitterAction
    }
    
    func refreshData(completionHandler: @escaping ((Result<Void, SessionTaskError>) -> Void)) {
        let request = StaffListAPIRequest()
        Session.send(request) { [weak self](result) in
            switch result {
            case .success(let staffs):
                self?.teams.removeAll()
                let teamNames = staffs.map({ $0.team }).unique()
                for tuple in teamNames.enumerated() {
                    self?.teams.append(Team(name: teamNames[tuple.offset], staffs: staffs.filter({ $0.team == teamNames[tuple.offset] })))
                }
                completionHandler(.success())
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
    // MARK: - Table View Controller Data Source

extension StaffListDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return teams[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams[section].staffs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? StaffTableViewCell else {
            fatalError("Could not create StaffTableViewCell")
        }
        cell.fill(staff: teams[(indexPath as NSIndexPath).section].staffs[(indexPath as NSIndexPath).row],
                  onFacebookButton: facebookAction(teams[(indexPath as NSIndexPath).section].staffs[(indexPath as NSIndexPath).row].facebook),
                  onTwitterButton: twitterAction(teams[(indexPath as NSIndexPath).section].staffs[(indexPath as NSIndexPath).row].twitter))
        return cell
    }
}
