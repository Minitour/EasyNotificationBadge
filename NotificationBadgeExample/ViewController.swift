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
    
    var currentFontSize:CGFloat = 12
    
    @IBAction func fontStepper(_ sender: UIStepper) {
        
        fontPreviewLabel.font = UIFont.systemFont(ofSize: CGFloat(sender.value))
        currentFontSize = CGFloat(sender.value)
    }
    
    
    @IBAction func update(_ sender: AnyObject) {
        var text:String?
        if badgeTextChanger.text?.characters.count == 0 {
            text = nil
        }else{
            text = badgeTextChanger.text
        }
        var appearnce = BadgeAppearnce()
        appearnce.backgroundColor = UIColor(colorLiteralRed: redSlider.value, green: greenSlider.value, blue: blueSlider.value, alpha: 1)
        appearnce.textSize = currentFontSize
        
        badgeLabel.badge(text: text, badgeEdgeInsets: UIEdgeInsetsMake(0, 0, 0, 0), appearnce: appearnce)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepper.maximumValue = 30
        stepper.minimumValue = 5
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        badgeLabel.badge(text: "2")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }


}

