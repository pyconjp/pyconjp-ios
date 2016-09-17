//
//  MoreListViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 3/7/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import SafariServices

class MoreListViewController: UITableViewController {
    
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
        guard let sectionType = SectionType(rawValue: indexPath.section) else { return }
        let rowType = sectionType.rows[indexPath.row]
        switch rowType {
        case .WhatsPyConJP, .CodeOfConduct, .Summary, .License, .StaffList:
            guard let identifier = rowType.identifier, viewController = self.storyboard?.instantiateViewControllerWithIdentifier(identifier) else { return }
            self.navigationController?.pushViewController(viewController, animated: true)
        case .Sponsor, .Repository:
            guard let url = rowType.url else { return }
            let safariViewController = SFSafariViewController(URL: url)
            self.presentViewController(safariViewController, animated: true, completion: nil)
        case .ConferenceMap:
            let mapListViewController = MapListViewController.build()
            self.navigationController?.pushViewController(mapListViewController, animated: true)
        case .SprintMap:
            let mapViewController = MapViewController.build(MapViewController.Venue.Microsoft)
            self.navigationController?.pushViewController(mapViewController, animated: true)
        case .Library:
            let acknowledgmentsListViewController = AcknowledgmentsListViewController.build()
            self.navigationController?.pushViewController(acknowledgmentsListViewController, animated: true)
        case .Feedback:
            guard let urlSheme = rowType.urlSheme else { return }
            UIApplication.sharedApplication().openURL(urlSheme)
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    private enum SectionType: Int {
        case About
        case Map
        case Application
        
        var rows: Array<RowType> {
            switch self {
            case .About:
                return [.WhatsPyConJP, .CodeOfConduct, .Summary, .Sponsor, .StaffList]
            case .Map:
                return [.ConferenceMap, .SprintMap]
            case .Application:
                return [.Repository, .Library, .License, .Feedback]
            }
        }
    
    }
    
    private enum RowType: MailURLSchemeType {
        case WhatsPyConJP
        case CodeOfConduct
        case Summary
        case Sponsor
        case StaffList
        
        case ConferenceMap
        case SprintMap
        
        case Repository
        case Library
        case License
        case Feedback
        
        var identifier: String? {
            switch self {
            case .WhatsPyConJP: return "WhatsPyConJPViewController"
            case .CodeOfConduct: return "CodeOfConductViewController"
            case .Summary: return "SummaryViewController"
            case .License: return "LicenseViewController"
            case .StaffList: return "StaffListViewController"
            default: return nil
            }
        }
        
        var url: NSURL? {
            switch self {
            case .Sponsor: return NSURL(string: PCJConfig.baseURL + "sponsors/")
            case .Repository: return NSURL(string: "https://github.com/pyconjp/pyconjp-ios")
            default: return nil
            }
        }
        
        var urlSheme: NSURL? {
            switch self {
            case .Feedback: return mailURLScheme(PCJConfig.mailAddress, subject: "Feedback for PyCon JP 2016 App", body: "iOS version:\nDevice Model:\nReply-to:\n\nFeedback:")
            default: return nil
            }
        }
        
    }
    
}
