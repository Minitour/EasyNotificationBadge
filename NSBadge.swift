//
//  ESTabBar+MIBadgeButton.swift
//  Mazaj
//
//  Created by Antonio Zaitoun on 8/10/16.
//  Copyright © 2016 New Sound Interactive. All rights reserved.
//


import UIKit

extension UIView {
    
    /*
     * Assign badge with only text.
     */
    public func badge(text badgeText: String!) {
        badge(text: badgeText, badgeEdgeInsets: UIEdgeInsetsMake(20, 0, 0, 15),appearnce: BadgeAppearnce())
    }
    
    /*
     * Assign badge with text and edge insets.
     */
    public func badge(text badgeText:String!,badgeEdgeInsets:UIEdgeInsets){
        badge(text: badgeText, badgeEdgeInsets: badgeEdgeInsets, appearnce: BadgeAppearnce())
    }
    
    /*
     * Assign badge with text,insets, and appearnce.
     */
    public func badge(text badgeText:String!,badgeEdgeInsets:UIEdgeInsets,appearnce:BadgeAppearnce){
        
        //Create badge label
        var badgeLabel:BadgeLabel!
        
        //Find badge in subviews if exists
        for view in self.subviews {
            if view.tag == 1 && view is BadgeLabel{
                badgeLabel = view as! BadgeLabel
            }
        }
        
        //If assigned text is nil (request to remove badge) and badge label is not nil:
        if badgeText == nil && !(badgeLabel == nil){
            
            //Remove badge label from superview and return.
            UIView.animate(withDuration: 0.2, animations: {badgeLabel.alpha = 0.0},
                                       completion: {(value: Bool) in
                                        badgeLabel.removeFromSuperview()
            })
            return
        }else if badgeText == nil && badgeLabel == nil {
            return
        }
        
        //Badge label is nil (There was no previous badge)
        if (badgeLabel == nil){
            
            //init badge label variable
            badgeLabel = BadgeLabel()
            
            //assign tag to badge label
            badgeLabel.tag = 1
        }
        
        //Clip to bounds
        badgeLabel.clipsToBounds = true
        
        //Set the text on the badge label
        badgeLabel.text = badgeText
        
        //Set font size
        badgeLabel.font = UIFont.systemFont(ofSize: appearnce.textSize)
        
        badgeLabel.sizeToFit()
        
        //set the allignment
        badgeLabel.textAlignment = appearnce.alignment
        
        //set background color
        badgeLabel.backgroundColor = appearnce.backgroundColor
        
        //set text color
        badgeLabel.textColor = appearnce.textColor
        
        //corner radius
        badgeLabel.layer.cornerRadius = badgeLabel.frame.size.height / 2
        
        //get current badge size
        let badgeSize = badgeLabel.frame.size
        
        //calculate width and height with minimum height and width of 20
        let height = max(20, Double(badgeSize.height) + 5.0)
        let width = max(height, Double(badgeSize.width) + 10.0)
        
        //calculate center point according to given edge insets
        var vertical: Double?, horizontal: Double?
        
        vertical = Double(badgeEdgeInsets.top) - Double(badgeEdgeInsets.bottom)
        horizontal = Double(badgeEdgeInsets.left) - Double(badgeEdgeInsets.right)
        
        let x = (Double(bounds.size.width) - 10 + horizontal!)
        let y = -(Double(badgeSize.height) / 2) - 10 + vertical!
        
        //set the badge frame
        badgeLabel.frame = CGRect(x: x, y: y, width: width, height: height)
        
        //add to subview
        addSubview(badgeLabel)
    }
    
}

/*
 * BadgeLabel - This class is made to avoid confusion with other subviews that might be of type UILabel.
 */
class BadgeLabel:UILabel{}

/*
 * BadgeAppearnce - This struct is used to design the badge.
 */
public struct BadgeAppearnce {
    var textSize:CGFloat = 12
    var alignment:NSTextAlignment = .center
    var backgroundColor = UIColor.red
    var textColor = UIColor.white
    
}

