//
//  FloorMapListViewController.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2016/08/05.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class FloorMapListViewController: UITableViewController {
    
    private let sections: [Section] = Section.sections
    
    class func build() -> FloorMapListViewController {
        return UIStoryboard(name: "More", bundle: Bundle.main).instantiateViewController(withIdentifier: "FloorMapListViewController") as! FloorMapListViewController
    }
    
    // MARK: - Table View Controller Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let floorMapZoomableImageViewController = FloorMapZoomableImageViewController.build(assetCatalog: sections[indexPath.section].rows[indexPath.row])
        self.present(floorMapZoomableImageViewController, animated: true, completion: nil)
    }
    
    private enum Section: Int {
        case firstFloor
        case secondFloor
        case thirdFloor
        
        static let sections: [Section] = [.firstFloor, .secondFloor, .thirdFloor]
        
        var rows: [FloorMapZoomableImageViewController.AssetCatalog] {
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
