//
//  FloorMapListViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/08/05.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
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
        let floorMapImageViewController = UIStoryboard(name: "More", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("FloorMapImageViewController") as! FloorMapImageViewController
        
        switch TableViewSection(rawValue: indexPath.section) ?? .FirstFloor {
        case .FirstFloor:
            floorMapImageViewController.assetCatalogType = FloorMapImageViewController.AssetCatalogType.FirstFloorView
        case .SecondFloor:
            switch indexPath.row {
            case 0:
                floorMapImageViewController.assetCatalogType = FloorMapImageViewController.AssetCatalogType.SecondFloorView
            case 1:
                floorMapImageViewController.assetCatalogType = FloorMapImageViewController.AssetCatalogType.SecondFloorRoom201
            case 2:
                floorMapImageViewController.assetCatalogType = FloorMapImageViewController.AssetCatalogType.SecondFloorRoom202
            case 3:
                floorMapImageViewController.assetCatalogType = FloorMapImageViewController.AssetCatalogType.SecondFloorRoom203
            case 4:
                floorMapImageViewController.assetCatalogType = FloorMapImageViewController.AssetCatalogType.SecondFloorRoom204
            case 5:
                floorMapImageViewController.assetCatalogType = FloorMapImageViewController.AssetCatalogType.SecondFloorRoom205
            default:
                break
            }
        case .ThirdFloor:
            floorMapImageViewController.assetCatalogType = FloorMapImageViewController.AssetCatalogType.ThirdFloorView
        }
        self.navigationController?.pushViewController(floorMapImageViewController, animated: true)
    }
    
    private enum TableViewSection: Int {
        case FirstFloor =  0
        case SecondFloor = 1
        case ThirdFloor = 2
    }
    
}
