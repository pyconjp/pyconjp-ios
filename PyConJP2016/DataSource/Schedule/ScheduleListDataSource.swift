//
//  ScheduleListDataSource.swift
//  PyConJP2016
//
//  Created by 牟田　裕太郎 on 2016/06/13.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class ScheduleListDataSource: NSObject, UITableViewDataSource {
  
    let reuseIdentifier = "ScheduleListTableViewCell"
    
    var talks: [Talk] = []

    // MARK: - Table View Controller Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "10:00~"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as? ScheduleListTableViewCell else {
            fatalError("Could not create ScheduleListTableViewCell")
        }
        return cell
    }
}
