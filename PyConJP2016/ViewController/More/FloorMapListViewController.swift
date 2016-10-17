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
        return UIStoryboard(name: "More", bundle: Bundle.main).instantiateViewController(withIdentifier: "FloorMapListViewController") as! FloorMapListViewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: - Table View Controller Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sectionType = SectionType(rawValue: (indexPath as NSIndexPath).section) else { return }
        let floorMapZoomableImageViewController = FloorMapZoomableImageViewController.build(assetCatalog: sectionType.rows[(indexPath as NSIndexPath).row])
        self.present(floorMapZoomableImageViewController, animated: true, completion: nil)
    }
    
    private enum SectionType: Int {
        case firstFloor
        case secondFloor
        case thirdFloor
        
        var rows: Array<FloorMapZoomableImageViewController.AssetCatalog> {
            switch self {
            case .firstFloor:
                return [.firstFloorView]
            case .secondFloor:
                return [.secondFloorView, .room201, .room202, .room203, .room204, .room205]
            case .thirdFloor:
                return [.thirdFloorView]
            }
        }
        
    }
    
}
