//
//  MapListViewController.swift
//  PyConJP
//
//  Created by Yutaro Muta on 8/5/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class MapListViewController: UITableViewController, StoryboardIdentifiable {
    
    static func build() -> MapListViewController {
        let mapListViewController: MapListViewController = UIStoryboard(storyboard: .more).instantiateViewController()
        return mapListViewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: - Table View Controller Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch TableViewCell(rawValue: indexPath.row) ?? .access {
        case .access:
            let mapViewController = MapViewController.build(venue: MapViewController.Venue.waseda)
            self.navigationController?.pushViewController(mapViewController, animated: true)
        case .floor:
            let floorListViewController = self.storyboard?.instantiateViewController(withIdentifier: "FloorMapListViewController")
            self.navigationController?.pushViewController(floorListViewController!, animated: true)
        }
    }
    
    private enum TableViewCell: Int {
        case access =  0
        case floor = 1
    }
    
}
