//
//  MoreViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 3/7/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

class MoreViewController: UITableViewController {

//    @IBOutlet weak var tableView: UITableView!
    
//    let moreDataSource = MoreDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.dataSource = moreDataSource
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//        if let indexPath = tableView.indexPathForSelectedRow {
//            tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        }
    }
    
    // MARK: - Table View Controller Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch TableViewSection(rawValue: indexPath.section) ?? .About {
        case .About:
            switch indexPath.row {
            case 0:
                let aboutViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AboutViewController")
                self.navigationController?.pushViewController(aboutViewController!, animated: true)
            case 1:
                break
            default:
                break
            }
        case .Map:
            switch indexPath.row {
            case 0:
                break
            case 1:
                break
            default:
                break
            }
//            let mapViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MapViewController") as! MapViewController
//            self.navigationController?.pushViewController(mapViewController, animated: true)
        case .Application:
            switch indexPath.row {
            case 0:
                break
            case 1:
                break
            case 2:
                break
            default:
                break
            }
//            let webViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PCJWKWebViewController") as! PCJWKWebViewController
//            webViewController.url = "https://github.com/pyconjp/pyconjp-ios"
//            self.navigationController?.pushViewController(webViewController, animated: true)
        }
    }

    private enum TableViewSection: Int {
        case About =  0
        case Map = 1
        case Application = 2
    }
    
}
