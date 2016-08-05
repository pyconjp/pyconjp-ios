//
//  MoreViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 3/7/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

class MoreViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    // MARK: - Table View Controller Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch TableViewSection(rawValue: indexPath.section) ?? .About {
        case .About:
            switch indexPath.row {
            case 0:
                let whatPyConJPViewController = self.storyboard?.instantiateViewControllerWithIdentifier("WhatPyConJPViewController")
                self.navigationController?.pushViewController(whatPyConJPViewController!, animated: true)
            case 1:
                let aboutViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AboutViewController")
                self.navigationController?.pushViewController(aboutViewController!, animated: true)
            default:
                break
            }
        case .Map:
            switch indexPath.row {
            case 0:
                let mapListViewController = MapListViewController.build()
                self.navigationController?.pushViewController(mapListViewController, animated: true)
            case 1:
                let mapViewController = MapViewController.build(MapViewController.Venue.Microsoft)
                self.navigationController?.pushViewController(mapViewController, animated: true)
            default:
                break
            }
        case .Application:
            switch indexPath.row {
            case 0:
                let webViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PCJWKWebViewController") as! PCJWKWebViewController
                webViewController.url = "https://github.com/pyconjp/pyconjp-ios"
                self.navigationController?.pushViewController(webViewController, animated: true)
            case 1:
                break
            case 2:
                let licenseViewController = self.storyboard?.instantiateViewControllerWithIdentifier("LicenseViewController")
                self.navigationController?.pushViewController(licenseViewController!, animated: true)
            default:
                break
            }
        }
    }

    private enum TableViewSection: Int {
        case About =  0
        case Map = 1
        case Application = 2
    }
    
}
