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
        let safariViewController = SFSafariViewController(URL: NSURL(string: rowType.url)!)
        self.presentViewController(safariViewController, animated: true, completion: nil)
    }
    
    private enum SectionType: Int {
        case TutorialsDay
        case ConferenseDay
        case SprintsDay
        
        var rows: Array<RowType> {
            switch self {
            case .TutorialsDay:
                return [.Tutorial]
            case .ConferenseDay:
                return [.Keynote, .InvitedLecture, .Posters, .LightningTalks, .YouthCoderWorkshop, .BeginnerSession, .CommitteeMeeting, .CommunityBooth, .JobFair, .ProductFair, .OpenSpace]
            case .SprintsDay:
                return [.Sprints]
            }
        }
        
    }
    
    private enum RowType {
        case Tutorial
        
        case Keynote
        case InvitedLecture
        case Posters
        case LightningTalks
        case YouthCoderWorkshop
        case BeginnerSession
        case CommitteeMeeting
        case CommunityBooth
        case JobFair
        case ProductFair
        case OpenSpace
        
        case Sprints
        
        var url: String {
            switch self {
            case .Tutorial: return PCJConfig.baseURL + "events/tutorial/"
            case .Keynote: return PCJConfig.baseURL + "keynote/"
            case .InvitedLecture: return PCJConfig.baseURL + "talks/invited-speaker/"
            case .Posters: return PCJConfig.baseURL + "schedule/posters/list/"
            case .LightningTalks: return PCJConfig.baseURL + "events/lightning-talks/"
            case .YouthCoderWorkshop: return PCJConfig.baseURL + "events/youth-ws/"
            case .BeginnerSession: return PCJConfig.baseURL + "events/beginners/"
            case .CommitteeMeeting: return PCJConfig.baseURL + "events/committee-meeting/"
            case .CommunityBooth: return PCJConfig.baseURL + "events/community-booth/"
            case .JobFair: return PCJConfig.baseURL + "events/jobsfair/"
            case .ProductFair: return PCJConfig.baseURL + "productfair/"
            case .OpenSpace: return PCJConfig.baseURL + "events/open-space/"
            case .Sprints: return PCJConfig.baseURL + "events/sprint/"
            }
        }
        
    }
}
