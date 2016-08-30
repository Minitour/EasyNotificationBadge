//
//  NSBadge.swift
//
//  Created by Antonio Zaitoun on 8/10/16.
//  Copyright © 2016 Crofis. All rights reserved.
//


import UIKit

extension UIView {
    
    /*
     * Assign badge with only text.
     */
    public func badge(text badgeText: String!) {
        badge(text: badgeText, badgeEdgeInsets: nil,appearnce: BadgeAppearnce())
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
    public func badge(text badgeText:String!,badgeEdgeInsets:UIEdgeInsets!,appearnce:BadgeAppearnce){
        
        //Create badge label
        var badgeLabel:BadgeLabel!
        
        var doesBadgeExist = false
        
        //Find badge in subviews if exists
        for view in self.subviews {
            if view.tag == 1 && view is BadgeLabel{
                badgeLabel = view as! BadgeLabel
            }
        }
        
        //If assigned text is nil (request to remove badge) and badge label is not nil:
        if badgeText == nil && !(badgeLabel == nil){
            
            if appearnce.animate{
                UIView.animate(withDuration: appearnce.duration, animations: {
                    badgeLabel.alpha = 0.0
                    badgeLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    
                    }, completion: { (Bool) in
                        
                        badgeLabel.removeFromSuperview()
                })
            }else{
                badgeLabel.removeFromSuperview()
            }
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
        }else{
            doesBadgeExist = true
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
        
        //get current badge size
        let badgeSize = badgeLabel.frame.size
        
        //calculate width and height with minimum height and width of 20
        let height = max(20, Double(badgeSize.height) + 5.0)
        let width = max(height, Double(badgeSize.width) + 10.0)
        
        //calculate center point according to given edge insets
        var vertical: Double?, horizontal: Double?
        
        if (badgeEdgeInsets != nil) {
            vertical = Double(badgeEdgeInsets.top) - Double(badgeEdgeInsets.bottom)
            horizontal = Double(badgeEdgeInsets.left) - Double(badgeEdgeInsets.right)
            
            let x = (Double(bounds.size.width) - 10 + horizontal!)
            let y = -(Double(badgeSize.height) / 2) - 10 + vertical!
            
            //set the badge frame
            badgeLabel.frame = CGRect(x: x, y: y, width: width, height: height)
        }else{
            let x = self.frame.width - CGFloat((width / 2.0))
            let y = CGFloat(-(height / 2.0))
            badgeLabel.frame = CGRect(x: x,y: y,width: CGFloat(width),height: CGFloat(height))
        }
        
        
        //add to subview
        addSubview(badgeLabel)
        
        //corner radius
        badgeLabel.layer.cornerRadius = badgeLabel.frame.size.height / 2
        
        if !doesBadgeExist {
            
            if appearnce.animate {
                UIView.animate(withDuration: appearnce.duration/2, animations: { () -> Void in
                    badgeLabel.transform = CGAffineTransform(scaleX: 0, y: 0)
                }) { (finished: Bool) -> Void in
                    UIView.animate(withDuration: appearnce.duration/2, animations: { () -> Void in
                        badgeLabel.transform = CGAffineTransform.identity
                    })}
            }
        }
    }
    
}


extension UIBarButtonItem {
    
    /*
     * Assign badge with only text.
     */
    public func badge(text badgeText: String!) {
        getView().badge(text: badgeText, badgeEdgeInsets: nil,appearnce: BadgeAppearnce())
    }
    
    /*
     * Assign badge with text and edge insets.
     */
    public func badge(text badgeText:String!,badgeEdgeInsets:UIEdgeInsets){
        getView().badge(text: badgeText, badgeEdgeInsets: badgeEdgeInsets, appearnce: BadgeAppearnce())
    }
    
    /*
     * Assign badge with text,insets, and appearnce.
     */
    public func badge(text badgeText:String!,badgeEdgeInsets:UIEdgeInsets!,appearnce:BadgeAppearnce){
        getView().badge(text: badgeText, badgeEdgeInsets: badgeEdgeInsets, appearnce: appearnce)
    }
    
    private func getView()->UIView{
        return value(forKey: "view") as! UIView
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
    var animate = true
    var duration = 0.2
    
}

