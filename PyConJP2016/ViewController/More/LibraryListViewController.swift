//
//  LibraryListViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/08/05.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import SafariServices

class LibraryListViewController: UITableViewController {
    
    class func build() -> LibraryListViewController {
        return UIStoryboard(name: "More", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("LibraryListViewController") as! LibraryListViewController
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    // MARK: - Table View Controller Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let safariViewController = SFSafariViewController(URL: NSURL(string: LibraryList(rawValue: indexPath.row)?.url ?? "")!)
        self.presentViewController(safariViewController, animated: true, completion: nil)
    }
    
    private enum LibraryList: Int {
        case Alamofire =  0
        case RealmSwift = 1
        
        var url: String {
            switch self {
            case .Alamofire:
                return "https://github.com/Alamofire/Alamofire"
            case .RealmSwift:
                return "https://realm.io/products/swift/"
            }
        }
    }
    
}
