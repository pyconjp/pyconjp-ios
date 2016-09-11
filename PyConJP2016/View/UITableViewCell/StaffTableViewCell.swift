//
//  StaffTableViewCell.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 9/10/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class StaffTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    
    static let estimatedRowHeight: CGFloat = 100
    
    private var facebookAction: (() -> Void)?
    private var twitterAction: (() -> Void)?
    
    func fill(staff: Staff, onFacebookButton: (() -> Void), onTwitterButton: (() -> Void)) {
        nameLabel.text = staff.name
        roleLabel.text = staff.role
        toggleFacebookButton(!staff.facebook.isEmpty)
        toggleTwitterButton(!staff.twitter.isEmpty)
        facebookAction = onFacebookButton
        twitterAction = onTwitterButton
    }
    
    override func prepareForReuse() {
        nameLabel.text = nil
        roleLabel.text = nil
        toggleFacebookButton(false)
        toggleTwitterButton(false)
    }
    
    private func toggleFacebookButton(enabled: Bool) {
        facebookButton.enabled = enabled
        facebookButton.backgroundColor = enabled ? UIColor.facebookColor() : UIColor.pyconJP2016GlayColor()
    }
    
    private func toggleTwitterButton(enabled: Bool) {
        twitterButton.enabled = enabled
        twitterButton.backgroundColor = enabled ? UIColor.twitterColor() : UIColor.pyconJP2016GlayColor()
    }
    
    @IBAction func onFacebookButton(sender: UIButton) {
        guard let facebookAction = facebookAction else { return }
        facebookAction()
    }
    
    @IBAction func onTwitterButton(sender: UIButton) {
        guard let twitterAction = twitterAction else { return }
        twitterAction()
    }
    
}
