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
        //appearance.allowShadow = true
        //appearance.borderColor = .white
        //appearance.borderWidth = 1
        //appearance.textSize = CGFloat(stepper.value)
        appearance.allowShadow = true
        appearance.backgroundColor = UIColor(colorLiteralRed: redSlider.value, green: greenSlider.value, blue: blueSlider.value, alpha: 1)

        badgeLabel.badge(text: text, appearance: appearance)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        stepper.maximumValue = 30
        stepper.minimumValue = 5
        //badgeLabel.badge(text: "test")
        //self.rightItem.badge(text: "lol")
        self.navigationItem.rightBarButtonItem = self.rightItem
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //badgeLabel.badge(text: "2")
        barButton.badge(text: "10")
        self.rightItem.badge(text: "lol")
        //barButton.badge(text: "!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }

}
