//
//  MoreListViewController.swift
//  PyConJP
//
//  Created by Yutaro Muta on 3/7/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import WebAPIFramework
import SafariServices

class MoreListViewController: UITableViewController {
    
    private let sections: [Section] = Section.sections
    
    // MARK: - Table View Controller DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell", for: indexPath)
        cell.textLabel?.text = sections[indexPath.section].rows[indexPath.row].title
        return cell
    }
    
    // MARK: - Table View Controller Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .whatsPyConJP, .codeOfConduct, .summary, .license, .staffList:
            guard let identifier = row.identifier, let viewController = self.storyboard?.instantiateViewController(withIdentifier: identifier) else { return }
            self.navigationController?.pushViewController(viewController, animated: true)
        case .participantsInformation, .sponsor, .repository:
            guard let url = row.url else { return }
            let safariViewController = SFSafariViewController(url: url)
            self.present(safariViewController, animated: true, completion: nil)
        case .conferenceMap:
            let mapListViewController = MapListViewController.build()
            self.navigationController?.pushViewController(mapListViewController, animated: true)
        case .sprintMap:
            let mapViewController = MapViewController.build(venue: MapViewController.Venue.microsoft)
            self.navigationController?.pushViewController(mapViewController, animated: true)
        case .feedback:
            guard let urlSheme = row.urlSheme else { return }
            UIApplication.shared.openURL(urlSheme)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private enum Section: Int {
        case about
        case venue
        case application
        
        static let sections: [Section] = [.about, .venue, .application]
        
        var rows: [Row] {
            switch self {
            case .about:
                return [.participantsInformation, .whatsPyConJP, .codeOfConduct, .summary, .sponsor, .staffList]
            case .venue:
                return [.conferenceMap, .sprintMap]
            case .application:
                return [.repository, .license, .feedback]
            }
        }
        
        var title: String? {
            switch self {
            case .about:
                return nil
            case .venue:
                return NSLocalizedString("venue", tableName: "MoreList", comment: "")
            case .application:
                return NSLocalizedString("application", tableName: "MoreList", comment: "")
            }
        }
        
    }
    
    private enum Row: MailURLSchemeProtocol {
        case participantsInformation
        case whatsPyConJP
        case codeOfConduct
        case summary
        case sponsor
        case staffList
        
        case conferenceMap
        case sprintMap
        
        case repository
        case license
        case feedback
        
        var title: String {
            switch self {
            case .participantsInformation:
                return NSLocalizedString("participantsInformation", tableName: "MoreList", comment: "")
            case .whatsPyConJP:
                return NSLocalizedString("whatsPyConJP", tableName: "MoreList", comment: "")
            case .codeOfConduct:
                return NSLocalizedString("codeOfConduct", tableName: "MoreList", comment: "")
            case .summary:
                return NSLocalizedString("summary", tableName: "MoreList", comment: "")
            case .sponsor:
                return NSLocalizedString("sponsor", tableName: "MoreList", comment: "")
            case .staffList:
                return NSLocalizedString("staffList", tableName: "MoreList", comment: "")
            case .conferenceMap:
                return NSLocalizedString("conferenceMap", tableName: "MoreList", comment: "")
            case .sprintMap:
                return NSLocalizedString("sprintMap", tableName: "MoreList", comment: "")
            case .repository:
                return NSLocalizedString("repository", tableName: "MoreList", comment: "")
            case .license:
                return NSLocalizedString("license", tableName: "MoreList", comment: "")
            case .feedback:
                return NSLocalizedString("feedback", tableName: "MoreList", comment: "")
            }
        }
        
        var identifier: String? {
            switch self {
            case .whatsPyConJP:
                return "WhatsPyConJPViewController"
            case .codeOfConduct:
                return "CodeOfConductViewController"
            case .summary:
                return "SummaryViewController"
            case .license:
                return "LicenseViewController"
            case .staffList:
                return "StaffListViewController"
            default:
                return nil
            }
        }
        
        var url: URL? {
            switch self {
            case .participantsInformation:
                return URL(string: WebConfig.baseURL + "participants/")
            case .sponsor:
                return URL(string: WebConfig.baseURL + "sponsors/")
            case .repository:
                return URL(string: "https://github.com/pyconjp/pyconjp-ios")
            default:
                return nil
            }
        }
        
        var urlSheme: URL? {
            switch self {
            case .feedback:
                return mailURLScheme(to: PCJConfig.mailAddress,
                                     subject: "Feedback for PyCon JP 2017 App",
                                     body: String(format: "iOS version: %@\nDevice Model: %@\nReply-to:\n\nFeedback:", arguments: [UIDevice.current.systemVersion, UIDevice.current.modelType]))
            default:
                return nil
            }
        }
        
    }
    
}
