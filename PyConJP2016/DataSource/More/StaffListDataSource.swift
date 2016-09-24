//
//  StaffListDataSource.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 9/10/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class StaffListDataSource: NSObject, UITableViewDataSource, StaffListAPIType {
    
    let reuseIdentifier = "StaffTableViewCell"
    
    var teams: [Team] = []
    
    let facebookAction: ((url: String) -> (() -> Void))
    let twitterAction: ((url: String) -> (() -> Void))
    
    init(facebookAction: ((url: String) -> (() -> Void)), twitterAction: ((url: String) -> (() -> Void))) {
        self.facebookAction = facebookAction
        self.twitterAction = twitterAction
    }
    
    func refreshData(completionHandler: (Result<Void, NSError> -> Void)) -> Void {
        getStaffs { [weak self](result) in
            guard let weakSelf = self else { return }
            switch result {
            case .Success(let staffs):
                weakSelf.teams.removeAll()
                let teamNames = staffs.map({ $0.team }).unique()
                for tuple in teamNames.enumerate() {
                    weakSelf.teams.append(Team(name: teamNames[tuple.index], staffs: staffs.filter({ $0.team == teamNames[tuple.index] })))
                }
                completionHandler(.Success())
            case .Failure(let error):
                completionHandler(.Failure(error))
            }
        }
    }
    
    // MARK: - Table View Controller Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return teams.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return teams[section].name
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams[section].staffs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as? StaffTableViewCell else {
            fatalError("Could not create StaffTableViewCell")
        }
        cell.fill(teams[indexPath.section].staffs[indexPath.row],
                  onFacebookButton: facebookAction(url: teams[indexPath.section].staffs[indexPath.row].facebook),
                  onTwitterButton: twitterAction(url: teams[indexPath.section].staffs[indexPath.row].twitter))
        return cell
    }
}
