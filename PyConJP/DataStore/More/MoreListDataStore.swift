//
//  MoreListDataStore.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/09/07.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import Foundation
import APIKit
import WebAPIFramework

final class MoreListDataStore {
    
    private(set) var sections: [Section]
    
    init(reloadData: @escaping (() -> Void)) {
        self.sections = []
        getSurveyURL { 
            reloadData()
        }
    }
    
    private func getSurveyURL(completionHandler: @escaping (() -> Void)) {
        let request = SurveyURLAPIRequest()
        Session.send(request) { [weak self](result) in
            switch result {
            case .success(let url):
                self?.sections = Section.sections(with: url)
                completionHandler()
            case .failure:
                self?.sections = Section.sections(with: nil)
                completionHandler()
            }
        }
    }
    
}

extension MoreListDataStore {

    enum Section {
        case about(rows: [Row])
        case venue(rows: [Row])
        case application(rows: [Row])
        
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
        
        var rows: [Row] {
            switch self {
            case .about(let rows):
                return rows
            case .venue(let rows):
                return rows
            case .application(let rows):
                return rows
            }
        }
        
        static func sections(with surveyURL: URL?) -> [Section] {
            if let surveyURL = surveyURL {
                return [.about(rows: [.participantsInformation,
                                      .whatsPyConJP,
                                      .codeOfConduct,
                                      .summary,
                                      .sponsor,
                                      .staffList,
                                      .survey(url: surveyURL)]),
                        .venue(rows: [.conferenceMap,
                                      .sprintMap]),
                        .application(rows: [.repository,
                                            .license,
                                            .feedback])]
            } else {
                return [.about(rows: [.participantsInformation,
                                      .whatsPyConJP,
                                      .codeOfConduct,
                                      .summary,
                                      .sponsor,
                                      .staffList]),
                        .venue(rows: [.conferenceMap,
                                      .sprintMap]),
                        .application(rows: [.repository,
                                            .license,
                                            .feedback])]
            }
        }
        
    }
    
    enum Row: MailURLSchemeProtocol {
        case participantsInformation
        case whatsPyConJP
        case codeOfConduct
        case summary
        case sponsor
        case staffList
        case survey(url: URL)
        
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
            case .survey:
                return NSLocalizedString("survey", tableName: "MoreList", comment: "")
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
