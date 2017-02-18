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
    
    override func prepareForReuse() {
        nameLabel.text = nil
        roleLabel.text = nil
        toggleFacebookButton(enabled: false)
        toggleTwitterButton(enabled: false)
    }
    
    func fill(staff: Staff, onFacebookButton: @escaping (() -> Void), onTwitterButton: @escaping (() -> Void)) {
        nameLabel.text = staff.name
        roleLabel.text = staff.role
        toggleFacebookButton(enabled: !staff.facebook.isEmpty)
        toggleTwitterButton(enabled: !staff.twitter.isEmpty)
        facebookAction = onFacebookButton
        twitterAction = onTwitterButton
    }
    
    private func toggleFacebookButton(enabled: Bool) {
        facebookButton.isEnabled = enabled
        facebookButton.backgroundColor = enabled ? UIColor.facebook : UIColor.PyConJP2016.gray
    }
    
    private func toggleTwitterButton(enabled: Bool) {
        twitterButton.isEnabled = enabled
        twitterButton.backgroundColor = enabled ? UIColor.twitter : UIColor.PyConJP2016.gray
    }
    
    @IBAction func onFacebookButton(_ sender: UIButton) {
        guard let facebookAction = facebookAction else { return }
        facebookAction()
    }
    
    @IBAction func onTwitterButton(_ sender: UIButton) {
        guard let twitterAction = twitterAction else { return }
        twitterAction()
    }
    
}
