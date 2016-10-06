//
//  FloorMapZoomableImageViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/08/05.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class FloorMapZoomableImageViewController: ZoomableImageViewController {
    
    var assetCatalogType: AssetCatalogType?
    
    func build(_ assetCatalogType: AssetCatalogType) -> FloorMapZoomableImageViewController {
        let floorMapImageViewController = UIStoryboard(name: "More", bundle: Bundle.main).instantiateViewController(withIdentifier: "FloorMapZoomableImageViewController") as! FloorMapZoomableImageViewController
        floorMapImageViewController.assetCatalogType = assetCatalogType
        return floorMapImageViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let assetCatalogType = assetCatalogType else { return }
        self.navigationItem.title = assetCatalogType.navigationItemTitle
        imageView?.image = UIImage(named: assetCatalogType.rawValue)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    enum AssetCatalogType: String {
        case firstFloorView = "FirstFloorMap"
        case secondFloorView = "SecondFloorMap"
        case thirdFloorView = "ThirdFloorMap"
        case room201 = "Room201Map"
        case room202 = "Room202Map"
        case room203 = "Room203Map"
        case room204 = "Room204Map"
        case room205 = "Room205Map"
        
        var navigationItemTitle: String {
            switch self {
            case .firstFloorView:
                return "1F"
            case .secondFloorView:
                return "2F"
            case .thirdFloorView:
                return "3F"
            case .room201:
                return "Room 201"
            case .room202:
                return "Room 202"
            case .room203:
                return "Room 203"
            case .room204:
                return "Room 204"
            case .room205:
                return "Room 205"
            }
        }
        
    }
    
}
