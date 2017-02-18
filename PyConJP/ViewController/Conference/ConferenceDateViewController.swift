//
//  ConferenceDateViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/07.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class ConferenceDateViewController: UIViewController, ConferenceDateViewProtocol {
    
    @IBOutlet weak var activeBar: UIView!
    @IBOutlet weak var day1Button: UIButton!
    @IBOutlet weak var day2Button: UIButton!
    
    private var buttonOriginXArray: [CGFloat] = []
    
    private var conferencePageViewProtocol: ConferencePageViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if buttonOriginXArray.isEmpty {
            view.subviews.filter({ $0 is UIButton }).forEach({ buttonOriginXArray.append($0.frame.origin.x) })
        }
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        guard let conferenceBaseViewController = parent as? ConferenceBaseViewController else { return }
        conferenceBaseViewController.conferenceDateViewProtocol = self
        conferencePageViewProtocol = conferenceBaseViewController.conferencePageViewProtocol
        
    }
    
    // MARK: - Day Button
    
    @IBAction func onDay1Button(_ sender: UIButton) {
        if let conferencePageViewProtocol = conferencePageViewProtocol {
            conferencePageViewProtocol.reversePage(index: 0)
            changeActive(index: 0)
        }
    }
    
    @IBAction func onDay2Button(_ sender: UIButton) {
        if let conferencePageViewProtocol = conferencePageViewProtocol {
            conferencePageViewProtocol.fowardPage(index: 1)
            changeActive(index: 1)
        }
    }
    
    // MARK: - ConferenceDateViewProtocol
    
    func changeActive(index: Int) {
        
        func changeActiveButton(_ button: UIButton) {
            button.isEnabled = false
            button.backgroundColor = .white
            button.setTitleColor(.black, for: UIControlState())
        }
        
        func changeUnactiveButton(_ button: UIButton) {
            button.isEnabled = true
            button.backgroundColor = UIColor.PyConJP2016.gray
            button.setTitleColor(.white, for: UIControlState())
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.activeBar.frame.origin.x = self.buttonOriginXArray[index]
            switch index {
            case 0:
                changeActiveButton(self.day1Button)
                changeUnactiveButton(self.day2Button)
            case 1:
                changeUnactiveButton(self.day1Button)
                changeActiveButton(self.day2Button)
            default:
                break
            }
        })
    }
    
}
