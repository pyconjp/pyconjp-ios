//
//  FloorMapImageViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/08/05.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class FloorMapImageViewController: DetailImageViewController {
    
    var assetCatalogType: AssetCatalogType?
    
    func build(assetCatalogType: AssetCatalogType) -> FloorMapImageViewController {
        let floorMapImageViewController = UIStoryboard(name: "More", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("FloorMapImageViewController") as! FloorMapImageViewController
        floorMapImageViewController.assetCatalogType = assetCatalogType
        return floorMapImageViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let assetCatalogType = assetCatalogType else { return }
        self.navigationItem.title = assetCatalogType.navigationItemTitle
        customImageView?.image = UIImage(named: assetCatalogType.rawValue)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    enum AssetCatalogType: String {
        case FirstFloorView = "FirstFloorMap"
        case SecondFloorView = "SecondFloorMap"
        case ThirdFloorView = "ThirdFloorMap"
        case SecondFloorRoom201 = "Room201Map"
        case SecondFloorRoom202 = "Room202Map"
        case SecondFloorRoom203 = "Room203Map"
        case SecondFloorRoom204 = "Room204Map"
        case SecondFloorRoom205 = "Room205Map"
        
        var navigationItemTitle: String {
            switch self {
            case .FirstFloorView:
                return "1F"
            case SecondFloorView:
                return "2F"
            case ThirdFloorView:
                return "3F"
            case SecondFloorRoom201:
                return "Room 201"
            case SecondFloorRoom202:
                return "Room 202"
            case SecondFloorRoom203:
                return "Room 203"
            case SecondFloorRoom204:
                return "Room 204"
            case SecondFloorRoom205:
                return "Room 205"
            }
        }
        
    }
    
}
