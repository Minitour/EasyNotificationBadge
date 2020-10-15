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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.badgeButton.badge(text: "1")
        }

        badgeButton.addTarget(self, action: #selector(didSelectButton(sender:)), for: .touchUpInside)
    }

    @objc
    func didSelectButton(sender: UIButton) {

        sender.badge(text: "Easy")
//        let rndStr = String.random()
//        let str: String? = rndStr.characters.count == 0 ? nil : rndStr
//        sender.badge(text: str)
    }
}

extension String {


    static func random(withLengthUpTo maxLength: Int = 10)-> String{
        let len = Int(arc4random_uniform(UInt32(maxLength)))
        return random(length: len)
    }

    static func random(length: Int) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""

        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.characters.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}
