//
//  MoreListViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 3/7/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import WebAPIFramework
import SafariServices

class MoreListViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    
    // MARK: - Table View Controller Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sectionType = SectionType(rawValue: (indexPath as NSIndexPath).section) else { return }
        let rowType = sectionType.rows[(indexPath as NSIndexPath).row]
        switch rowType {
        case .whatsPyConJP, .codeOfConduct, .summary, .license, .staffList:
            guard let identifier = rowType.identifier, let viewController = self.storyboard?.instantiateViewController(withIdentifier: identifier) else { return }
            self.navigationController?.pushViewController(viewController, animated: true)
        case .participantsInformation, .sponsor, .questionnaire, .repository:
            guard let url = rowType.url else { return }
            let safariViewController = SFSafariViewController(url: url)
            self.present(safariViewController, animated: true, completion: nil)
        case .conferenceMap:
            let mapListViewController = MapListViewController.build()
            self.navigationController?.pushViewController(mapListViewController, animated: true)
        case .sprintMap:
            let mapViewController = MapViewController.build(venue: MapViewController.Venue.microsoft)
            self.navigationController?.pushViewController(mapViewController, animated: true)
        case .library:
            let acknowledgmentsListViewController = AcknowledgmentsListViewController.build()
            self.navigationController?.pushViewController(acknowledgmentsListViewController, animated: true)
        case .feedback:
            guard let urlSheme = rowType.urlSheme else { return }
            UIApplication.shared.openURL(urlSheme)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private enum SectionType: Int {
        case about
        case map
        case application
        
        var rows: Array<RowType> {
            switch self {
            case .about:
                return [.participantsInformation, .whatsPyConJP, .codeOfConduct, .summary, .sponsor, .staffList, .questionnaire]
            case .map:
                return [.conferenceMap, .sprintMap]
            case .application:
                return [.repository, .library, .license, .feedback]
            }
        }
        
    }
    
    private enum RowType: MailURLSchemeProtocol {
        case participantsInformation
        case whatsPyConJP
        case codeOfConduct
        case summary
        case sponsor
        case staffList
        case questionnaire
        
        case conferenceMap
        case sprintMap
        
        case repository
        case library
        case license
        case feedback
        
        var identifier: String? {
            switch self {
            case .whatsPyConJP: return "WhatsPyConJPViewController"
            case .codeOfConduct: return "CodeOfConductViewController"
            case .summary: return "SummaryViewController"
            case .license: return "LicenseViewController"
            case .staffList: return "StaffListViewController"
            default: return nil
            }
        }
        
        var url: URL? {
            switch self {
            case .participantsInformation: return URL(string: WebConfig.baseURL + "participants/")
            case .sponsor: return URL(string: WebConfig.baseURL + "sponsors/")
            case .questionnaire: return URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSefOgaVN8_cwUAcW-NmTaBNoNG8K47vursedtxkE_cbv_E37A/viewform")
            case .repository: return URL(string: "https://github.com/pyconjp/pyconjp-ios")
            default: return nil
            }
        }
        
        var urlSheme: URL? {
            switch self {
            case .feedback: return mailURLScheme(to: PCJConfig.mailAddress,
                                                 subject: "Feedback for PyCon JP 2016 App",
                                                 body: String(format: "iOS version: %@\nDevice Model: %@\nReply-to:\n\nFeedback:", arguments: [UIDevice.current.systemVersion, UIDevice.current.modelType]))
            default: return nil
            }
        }
        
    }
    
}
