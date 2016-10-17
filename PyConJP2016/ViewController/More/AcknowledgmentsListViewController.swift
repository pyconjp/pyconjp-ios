//
//  AcknowledgmentsListViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/08/05.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import SafariServices

class AcknowledgmentsListViewController: UITableViewController {
    
    class func build() -> AcknowledgmentsListViewController {
        return UIStoryboard(name: "More", bundle: Bundle.main).instantiateViewController(withIdentifier: "AcknowledgmentsListViewController") as! AcknowledgmentsListViewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: - Table View Controller Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rowType = RowType(rawValue: (indexPath as NSIndexPath).row) else { return }
        switch rowType {
        case .alamofire, .alamofireImage:
            guard let identifier = rowType.identifier else { return }
            let licenseViewController = UIStoryboard(name: "More", bundle: Bundle.main).instantiateViewController(withIdentifier: identifier)
            self.navigationController?.pushViewController(licenseViewController, animated: true)
        case .realmSwift:
            guard let url = rowType.url else { return }
            let safariViewController = SFSafariViewController(url: URL(string: url)!)
            self.present(safariViewController, animated: true, completion: nil)
        }
    }
    
    private enum RowType: Int {
        case alamofire =  0
        case alamofireImage = 1
        case realmSwift = 2
        
        var identifier: String? {
            switch self {
            case .alamofire: return "AlamofireLicenseViewController"
            case .alamofireImage: return  "AlamofireImageLicenseViewController"
            default: return nil
            }
        }
        
        var url: String? {
            switch self {
            case .realmSwift: return "https://realm.io/products/swift/"
            default: return nil
            }
        }
        
    }
    
}
