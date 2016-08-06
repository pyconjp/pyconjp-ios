//
//  FloorMapImageViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/08/05.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
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
        case FirstFloorView = "WasedaFirstFloorMap"
        case SecondFloorView = "WasedaSecondFloorMap"
        case ThirdFloorView = "WasedaThirdFloorMap"
        case SecondFloorRoom201 = "WasedaRoom201Map"
        case SecondFloorRoom202 = "WasedaRoom202Map"
        case SecondFloorRoom203 = "WasedaRoom203Map"
        case SecondFloorRoom204 = "WasedaRoom204Map"
        case SecondFloorRoom205 = "WasedaRoom205Map"
        
    }
    
}
