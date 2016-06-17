//
//  MoreDataSource.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/06/17.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class MoreDataSource: NSObject, UITableViewDataSource {

    // MARK: - Table View Controller Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1, 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "About"
        case 1:
            cell.textLabel?.text = "Access"
        case 2:
            cell.textLabel?.text = "Repository"
        default:
            break
        }
        return cell
    }
}
