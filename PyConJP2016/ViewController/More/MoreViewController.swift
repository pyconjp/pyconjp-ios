//
//  MoreViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 3/7/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    //mark UITableViewDelegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1, 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "About"
        case 1 where indexPath.row == 0:
            cell.textLabel?.text = "Access"
        case 2:
            cell.textLabel?.text = "Repository"
        default:
            break
        }
        return cell
    }
    
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
