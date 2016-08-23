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
        
    }
    
}
