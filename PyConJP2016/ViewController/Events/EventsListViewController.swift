//
//  EventsListViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 8/27/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import SafariServices

class EventsListViewController: UITableViewController {
    
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
        let safariViewController = SFSafariViewController(url: URL(string: rowType.url)!)
        self.present(safariViewController, animated: true, completion: nil)
    }
    
    private enum SectionType: Int {
        case tutorialsDay
        case conferenseDay
        case sprintsDay
        
        var rows: Array<RowType> {
            switch self {
            case .tutorialsDay:
                return [.tutorial]
            case .conferenseDay:
                return [.keynote, .invitedLecture, .posters, .lightningTalks, .youthCoderWorkshop, .beginnerSession, .committeeMeeting, .communityBooth, .jobFair, .productFair, .openSpace]
            case .sprintsDay:
                return [.sprints]
            }
        }
        
    }
    
    private enum RowType {
        case tutorial
        
        case keynote
        case invitedLecture
        case posters
        case lightningTalks
        case youthCoderWorkshop
        case beginnerSession
        case committeeMeeting
        case communityBooth
        case jobFair
        case productFair
        case openSpace
        
        case sprints
        
        var url: String {
            switch self {
            case .tutorial: return PCJConfig.baseURL + "events/tutorial/"
            case .keynote: return PCJConfig.baseURL + "keynote/"
            case .invitedLecture: return PCJConfig.baseURL + "talks/invited-speaker/"
            case .posters: return PCJConfig.baseURL + "schedule/posters/list/"
            case .lightningTalks: return PCJConfig.baseURL + "events/lightning-talks/"
            case .youthCoderWorkshop: return PCJConfig.baseURL + "events/youth-ws/"
            case .beginnerSession: return PCJConfig.baseURL + "events/beginners/"
            case .committeeMeeting: return PCJConfig.baseURL + "events/committee-meeting/"
            case .communityBooth: return PCJConfig.baseURL + "events/community-booth/"
            case .jobFair: return PCJConfig.baseURL + "events/jobsfair/"
            case .productFair: return PCJConfig.baseURL + "productfair/"
            case .openSpace: return PCJConfig.baseURL + "events/open-space/"
            case .sprints: return PCJConfig.baseURL + "events/sprint/"
            }
        }
        
    }
}
