//
//  ViewController.swift
//  NotificationBadgeExample
//
//  Created by Antonio Zaitoun on 8/11/16.
//  Copyright © Crofis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var badgeLabel: UILabel!
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    @IBOutlet var badgeTextChanger: UITextField!
    @IBOutlet var fontPreviewLabel: UILabel!
    @IBOutlet var fontSizeStepper: UIStepper!
    @IBOutlet var stepper: UIStepper!

    @IBOutlet weak var barButton: UIBarButtonItem!
    var currentFontSize: CGFloat = 12

    lazy var rightItem: UIBarButtonItem = UIBarButtonItem(title: "Test", style: .plain, target: nil, action: nil)

    @IBAction func fontStepper(_ sender: UIStepper) {
        fontPreviewLabel.font = UIFont.systemFont(ofSize: CGFloat(sender.value))
        currentFontSize = CGFloat(sender.value)
    }

    var counter = 0

    @IBAction func menuClick(_ sender: UIBarButtonItem) {
        counter += 1
        sender.badge(text: "\(counter)")
    }

    @IBAction func update(_ sender: AnyObject) {
        var text: String?
        if badgeTextChanger.text?.characters.count == 0 {
            text = nil
        } else {
            text = badgeTextChanger.text
        }
        var appearance = BadgeAppearance()
        appearance.allowShadow = true
        appearance.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)

        badgeLabel.badge(text: text, appearance: appearance)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        stepper.maximumValue = 30
        stepper.minimumValue = 5

        self.navigationItem.rightBarButtonItem = self.rightItem
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        barButton.badge(text: "10")
        self.rightItem.badge(text: "!")
    }

}
