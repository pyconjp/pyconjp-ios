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
    
    // MARK: - Table View Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return timelines.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return timelines[section].key
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timelines[section].talks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? TalkTableViewCell else {
            fatalError("Could not create TalkTableViewCell")
        }
        cell.fill(talkObject: timelines[(indexPath as NSIndexPath).section].talks[(indexPath as NSIndexPath).row])
        return cell
    }
}
