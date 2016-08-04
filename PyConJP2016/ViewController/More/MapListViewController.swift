//
//  MapListViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 8/5/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

class MapListViewController: UITableViewController {
    
    class func build() -> MapListViewController {
        return UIStoryboard(name: "More", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("MapListViewController") as! MapListViewController
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    // MARK: - Table View Controller Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch TableViewCell(rawValue: indexPath.row) ?? .Access {
        case .Access:
            let mapViewController = MapViewController.build(MapViewController.Venue.Waseda)
            self.navigationController?.pushViewController(mapViewController, animated: true)
        case .Floor:
            let floorListViewController = self.storyboard?.instantiateViewControllerWithIdentifier("FloorMapListViewController")
            self.navigationController?.pushViewController(floorListViewController!, animated: true)
        }
    }
    
    private enum TableViewCell: Int {
        case Access =  0
        case Floor = 1
    }


}
