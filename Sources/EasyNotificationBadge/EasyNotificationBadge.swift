//
//  EasyNotificationBadge.swift
//
//  Created by Antonio Zaitoun on 8/10/16.
//  Copyright © 2016 Crofis. All rights reserved.
//

import UIKit

extension UIView {
    /// Assign badge with only text.
    ///
    /// - Parameter text: The badge value, use nil to remove exsiting badge.
    @objc public func badge(text badgeText: String?) {
        badge(text: badgeText, appearance: BadgeAppearance())
    }

    /// - Parameters:
    ///     - text: The badge value, use nil to remove exsiting badge.
    ///     - appearance: The appearance of the badge.
    public func badge(text badgeText: String?, appearance: BadgeAppearance) {
        badge(text: badgeText, badgeEdgeInsets: nil, appearance: appearance)
    }

    /// Assign badge with text and edge insets.
    @available(*, deprecated, message: "Use badge(text: String?, appearance: BadgeAppearance)")
    @objc public func badge(text badgeText: String?, badgeEdgeInsets: UIEdgeInsets) {
        badge(text: badgeText, badgeEdgeInsets: badgeEdgeInsets, appearance: BadgeAppearance())
    }

    /// Assign badge with text,insets, and appearance.
    public func badge(text badgeText: String?, badgeEdgeInsets: UIEdgeInsets?, appearance: BadgeAppearance) {
        // Create badge label
        var badgeLabel: BadgeLabel?
        var doesBadgeExist = false

        // Find badge in subviews if exists
        for view in self.subviews where view.tag == 1 && view is BadgeLabel {
            badgeLabel = view as? BadgeLabel
        }

        // If assigned text is nil (request to remove badge) and badge label is not nil:
        if badgeText == nil && badgeLabel != nil {
            if appearance.animate {
                UIView.animate(withDuration: appearance.duration, animations: {
                    badgeLabel?.alpha = 0.0
                    badgeLabel?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                }, completion: { (_) in
                    badgeLabel?.removeFromSuperview()
                })
            } else {
                badgeLabel?.removeFromSuperview()
            }

            return
        } else if badgeText == nil && badgeLabel == nil {
            return
        }

        // Badge label is nil (There was no previous badge)
        if badgeLabel == nil {
            // init badge label variable
            badgeLabel = BadgeLabel()
            // assign tag to badge label
            badgeLabel?.tag = 1
        } else {
            doesBadgeExist = true
        }

        let oldWidth: CGFloat? = doesBadgeExist ? badgeLabel?.frame.width : nil

        // Set the text on the badge label
        badgeLabel?.text = badgeText
        // Set font size
        badgeLabel?.font = appearance.font
        badgeLabel?.sizeToFit()

        // set the allignment
        badgeLabel?.textAlignment = appearance.textAlignment
        // set background color
        badgeLabel?.layer.backgroundColor = appearance.backgroundColor.cgColor
        // set text color
        badgeLabel?.textColor = appearance.textColor

        // get current badge size
        // calculate width and height with minimum height and width of 20
        let badgeSize = badgeLabel?.frame.size
        var height = max(18, (badgeSize?.height ?? 0.0) + 5.0)
        var width = max(height, (badgeSize?.width ?? 0.0) + 10.0)
        if appearance.radius > 0 {
            height = appearance.radius
            width = appearance.radius
        }
        badgeLabel?.frame.size = CGSize(width: width, height: height)

        // add to subview
        if doesBadgeExist {
            // remove view to delete constraints
            badgeLabel?.removeFromSuperview()
        }

        if let badgeLabel = badgeLabel {
            self.addSubview(badgeLabel)
        }

        // The distance from the center of the view (vertically)
        let centerY = appearance.distanceFromCenterY == 0 ? -(bounds.size.height / 2) : appearance.distanceFromCenterY
        // The distance from the center of the view (horizontally)
        let centerX = appearance.distanceFromCenterX == 0 ? (bounds.size.width / 2) : appearance.distanceFromCenterX

        // disable auto resizing mask
        badgeLabel?.translatesAutoresizingMaskIntoConstraints = false

        // add height constraint
        addConstraints([
            // add height constraint
            NSLayoutConstraint(item: badgeLabel as Any,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1.0,
                               constant: CGFloat(height)),
            // add width constraint
            NSLayoutConstraint(item: badgeLabel as Any,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1.0,
                               constant: CGFloat(width)),
            // add vertical constraint
            NSLayoutConstraint(item: badgeLabel as Any,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .centerX,
                               multiplier: 1.0,
                               constant: centerX),
            // add horizontal constraint
            NSLayoutConstraint(item: badgeLabel as Any,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .centerY,
                               multiplier: 1.0,
                               constant: centerY)
        ])

        badgeLabel?.layer.borderColor = appearance.borderColor.cgColor
        badgeLabel?.layer.borderWidth = appearance.borderWidth

        let badgeLabelHeight = badgeLabel?.frame.size.height ?? 0.0
        // corner radius
        badgeLabel?.layer.cornerRadius = badgeLabelHeight / 2

        // setup shadow
        if appearance.allowShadow {
            badgeLabel?.layer.shadowOffset = CGSize(width: 1, height: 1)
            badgeLabel?.layer.shadowRadius = 1
            badgeLabel?.layer.shadowOpacity = 0.5
            badgeLabel?.layer.shadowColor = UIColor.black.cgColor
        }

        // badge does not exist, meaning we are adding a new one
        if !doesBadgeExist {
            // should it animate?
            if appearance.animate {
                badgeLabel?.transform = CGAffineTransform(scaleX: 0, y: 0)

                UIView.animate(withDuration: appearance.duration,
                               delay: 0,
                               usingSpringWithDamping: 0.5,
                               initialSpringVelocity: 0.5,
                               options: [],
                               animations: {
                                badgeLabel?.transform = .identity
                               },
                               completion: nil)
            }
        } else {
            if appearance.animate, let oldWidth = oldWidth {
                let currentWidth = badgeLabel?.frame.width ?? 0.0
                badgeLabel?.frame.size.width = oldWidth
                UIView.animate(withDuration: appearance.duration) {
                    badgeLabel?.frame.size.width = currentWidth
                }
            }
        }
    }
}

extension UIBarButtonItem {
    /// Assign badge with only text.
    @objc public func badge(text: String?) {
        badge(text: text, appearance: BadgeAppearance())
    }

    public func badge(text badgeText: String?, appearance: BadgeAppearance = BadgeAppearance()) {
        if let view = badgeViewHolder {
            getView(in: view).badge(text: badgeText, appearance: appearance)
        } else {
            NSLog("Attempted setting badge with value '\(badgeText ?? "nil")' on a nil UIBarButtonItem view.")
        }
    }

    private var badgeViewHolder: UIView? {
        return value(forKey: "view") as? UIView
    }

    private func getView(in holder: UIView) -> UIView {
        for sub in holder.subviews where "\(type(of: sub))" == "_UIModernBarButton" {
            return sub
        }

        return holder
    }
}

/// BadgeLabel - This class is made to avoid confusion with other subviews that might be of type UILabel.
@objc class BadgeLabel: UILabel {}

/// BadgeAppearance - This struct is used to design the badge.
public struct BadgeAppearance {
    public var font: UIFont
    public var textAlignment: NSTextAlignment
    public var borderColor: UIColor
    public var borderWidth: CGFloat
    public var allowShadow: Bool
    public var backgroundColor: UIColor
    public var textColor: UIColor
    public var animate: Bool
    public var duration: TimeInterval
    public var distanceFromCenterY: CGFloat
    public var distanceFromCenterX: CGFloat
    public var radius: CGFloat?

    public init() {
        font = .systemFont(ofSize: 12)
        textAlignment = .center
        backgroundColor = .red
        textColor = .white
        animate = true
        duration = 0.2
        borderColor = .clear
        borderWidth = 0
        allowShadow = false
        distanceFromCenterY = 0
        distanceFromCenterX = 0
        radius = 0
    }
}
