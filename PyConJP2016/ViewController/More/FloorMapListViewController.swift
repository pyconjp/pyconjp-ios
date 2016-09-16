//
//  FloorMapListViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/08/05.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class FloorMapListViewController: UITableViewController {
    
    class func build() -> FloorMapListViewController {
        return UIStoryboard(name: "More", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("FloorMapListViewController") as! FloorMapListViewController
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    // MARK: - Table View Controller Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let sectionType = SectionType(rawValue: indexPath.section) else { return }
        let floorMapZoomableImageViewController = UIStoryboard(name: "More", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("FloorMapZoomableImageViewController") as! FloorMapZoomableImageViewController
        floorMapZoomableImageViewController.assetCatalogType = sectionType.rows[indexPath.row]
        self.presentViewController(floorMapZoomableImageViewController, animated: true, completion: nil)
    }
    
    private enum SectionType: Int {
        case FirstFloor
        case SecondFloor
        case ThirdFloor
        
        var rows: Array<FloorMapZoomableImageViewController.AssetCatalogType> {
            switch self {
            case .FirstFloor:
                return [.FirstFloorView]
            case .SecondFloor:
                return [.SecondFloorView, .Room201, .Room202, .Room203, .Room204, .Room205]
            case .ThirdFloor:
                return [.ThirdFloorView]
            }
        }
        
    }
    
}
