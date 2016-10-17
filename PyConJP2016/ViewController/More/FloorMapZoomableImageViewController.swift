//
//  FloorMapZoomableImageViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/08/05.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class FloorMapZoomableImageViewController: ZoomableImageViewController {
    
    private var assetCatalog: AssetCatalog?
    
    static func build(assetCatalog: AssetCatalog) -> FloorMapZoomableImageViewController {
        let floorMapImageViewController = UIStoryboard(name: "More", bundle: Bundle.main).instantiateViewController(withIdentifier: "FloorMapZoomableImageViewController") as! FloorMapZoomableImageViewController
        floorMapImageViewController.assetCatalog = assetCatalog
        return floorMapImageViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let assetCatalog = assetCatalog else { return }
        imageView?.image = assetCatalog.image
    }
    
    enum AssetCatalog {
        case firstFloorView
        case secondFloorView
        case thirdFloorView
        case room201
        case room202
        case room203
        case room204
        case room205
        
        var title: String {
            switch self {
            case .firstFloorView: return "1F"
            case .secondFloorView: return "2F"
            case .thirdFloorView: return "3F"
            case .room201: return "Room 201"
            case .room202: return "Room 202"
            case .room203: return "Room 203"
            case .room204: return "Room 204"
            case .room205: return "Room 205"
            }
        }
        
        var image: UIImage {
            switch self {
            case .firstFloorView: return #imageLiteral(resourceName: "FirstFloorMap")
            case .secondFloorView: return #imageLiteral(resourceName: "SecondFloorMap")
            case .thirdFloorView: return #imageLiteral(resourceName: "ThirdFloorMap")
            case .room201: return #imageLiteral(resourceName: "Room201Map")
            case .room202: return #imageLiteral(resourceName: "Room202Map")
            case .room203: return #imageLiteral(resourceName: "Room203Map")
            case .room204: return #imageLiteral(resourceName: "Room204Map")
            case .room205: return #imageLiteral(resourceName: "Room205Map")
            }
        }
        
    }
    
}
