//
//  MoreViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 3/7/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let moreDataSource = MoreDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = moreDataSource
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table View Controller Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            let aboutViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AboutViewController")
            self.navigationController?.pushViewController(aboutViewController!, animated: true)
            break
        case 1:
            let mapViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MapViewController") as! MapViewController
            self.navigationController?.pushViewController(mapViewController, animated: true)
        case 2:
            let webViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PCJWKWebViewController") as! PCJWKWebViewController
            webViewController.url = "https://github.com/pyconjp/pyconjp-ios"
            self.navigationController?.pushViewController(webViewController, animated: true)
        default:
            break
        }
    }

}
