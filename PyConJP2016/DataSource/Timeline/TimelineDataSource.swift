//
//  TimelineDataSource.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 8/19/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class TimelineDataSource: NSObject, UITableViewDataSource {
    
    let reuseIdentifier = "TalkTableViewCell"
    
    var timelines: [Timeline] = []
    
    // MARK: - Table View Controller Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return timelines.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return timelines[section].key
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timelines[section].talks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as? TalkTableViewCell else {
            fatalError("Could not create ScheduleListTableViewCell")
        }
        cell.fillWith(timelines[indexPath.section].talks[indexPath.row])
        return cell
    }
}
