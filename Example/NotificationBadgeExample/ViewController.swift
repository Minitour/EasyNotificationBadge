//
//  ViewController.swift
//  NotificationBadgeExample
//
//  Created by Antonio Zaitoun on 8/11/16.
//  Copyright © Crofis. All rights reserved.
//

import UIKit
import EasyNotificationBadge

class ViewController: UIViewController {
    @IBOutlet weak var badgeButton: UIButton!

    var appearance = BadgeAppearance(animate: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) { [self] in
            self.badgeButton.badge(text: "1", appearance: appearance)
        }

        badgeButton.addTarget(self, action: #selector(didSelectButton(sender:)), for: .touchUpInside)
    }

    @objc
    func didSelectButton(sender: UIButton) {
        defer {
            sender.tag += 1
        }
        if sender.tag == 0 {
            sender.badge(text: "Easy", appearance: appearance)
        } else if sender.tag == 1 {
            sender.badge(text: nil, appearance: appearance)
        } else {
            sender.badge(text: "\(sender.tag - 1)", appearance: appearance)
        }
    }
}
