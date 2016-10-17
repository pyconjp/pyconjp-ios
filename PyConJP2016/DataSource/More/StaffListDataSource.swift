//
//  StaffListDataSource.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 9/10/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class StaffListDataSource: NSObject, UITableViewDataSource, StaffListAPIProtocol {
    
    let reuseIdentifier = "StaffTableViewCell"
    
    var teams: [Team] = []
    
    let facebookAction: ((_ url: String) -> (() -> Void))
    let twitterAction: ((_ url: String) -> (() -> Void))
    
    init(facebookAction: @escaping ((_ url: String) -> (() -> Void)), twitterAction: @escaping ((_ url: String) -> (() -> Void))) {
        self.facebookAction = facebookAction
        self.twitterAction = twitterAction
    }
    
    func refreshData(completionHandler: @escaping ((Result<Void>) -> Void)) -> Void {
        getStaffs { [weak self](result) in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let staffs):
                weakSelf.teams.removeAll()
                let teamNames = staffs.map({ $0.team }).unique()
                for tuple in teamNames.enumerated() {
                    weakSelf.teams.append(Team(name: teamNames[tuple.offset], staffs: staffs.filter({ $0.team == teamNames[tuple.offset] })))
                }
                completionHandler(.success())
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    // MARK: - Table View Controller Data Source
    
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
