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


    /// Assign badge with text,insets, and appearance.
    /// - Parameters:
    ///     - text: The badge value, use nil to remove exsiting badge.
    ///     - appearance: The appearance of the badge.
    public func badge(text badgeText: String?, appearance: BadgeAppearance) {
        // Create badge label
        var badgeLabel: BadgeLabel?
        var doesBadgeExist = false

        // Find badge in subviews if exists
        for view in self.subviews where view.tag == 1 && view is BadgeLabel {
            badgeLabel = view as? BadgeLabel
        }

        // If assigned text is nil (request to remove badge) and badge label is not nil:
        if badgeText == nil && badgeLabel != nil {
            removeBadgeLabel(badgeLabel!, appearance: appearance)
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

        guard let badgeLabelView = badgeLabel else { return }

        let oldWidth: CGFloat? = doesBadgeExist ? badgeLabelView.frame.width : nil

        // Set the text on the badge label
        badgeLabelView.text = badgeText
        // Set font size
        badgeLabelView.font = appearance.font
        badgeLabelView.sizeToFit()

        layoutLabel(badgeLabelView, appearance: appearance, doesBadgeExist: doesBadgeExist)

        applyStyle(label: badgeLabelView, appearance: appearance)

        // badge does not exist, meaning we are adding a new one
        animateBadgeAppearance(label: badgeLabelView, appearance: appearance, doesBadgeExist: doesBadgeExist, oldWidth: oldWidth)
    }

    fileprivate func layoutLabel(_ label: BadgeLabel, appearance:  BadgeAppearance, doesBadgeExist: Bool) {
        // get current badge size
        // calculate width and height with minimum height and width of 20
        let badgeSize = label.frame.size
        var height = max(18, (badgeSize.height) + 5.0)
        var width = max(height, (badgeSize.width) + 10.0)
        if let radius = appearance.radius {
            height = radius
            width = radius
        }
        label.frame.size = CGSize(width: width, height: height)

        // add to subview
        if doesBadgeExist {
            // delete constraints
            NSLayoutConstraint.deactivate(label.constraints)
        } else {
            addSubview(label)
            // disable auto resizing mask
            label.translatesAutoresizingMaskIntoConstraints = false
        }

        // The distance from the center of the view (vertically)
        let centerY = appearance.distanceFromCenterY == nil ? -(bounds.size.height / 2) : appearance.distanceFromCenterY!
        // The distance from the center of the view (horizontally)
        let centerX = appearance.distanceFromCenterX == nil ? (bounds.size.width / 2) : appearance.distanceFromCenterX!

        // add constraints
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: height),
            label.widthAnchor.constraint(equalToConstant: width),
            label.centerXAnchor.constraint(equalTo: centerXAnchor, constant: centerX),
            label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: centerY)
        ])
    }

    fileprivate func applyStyle(label: BadgeLabel, appearance: BadgeAppearance) {

        // set the allignment
        label.textAlignment = appearance.textAlignment
        // set background color
        label.layer.backgroundColor = appearance.backgroundColor.cgColor
        // set text color
        label.textColor = appearance.textColor

        label.layer.borderColor = appearance.borderColor.cgColor
        label.layer.borderWidth = appearance.borderWidth

        let badgeLabelHeight = label.frame.size.height
        // corner radius
        label.layer.cornerRadius = badgeLabelHeight / 2

        // setup shadow
        if appearance.allowShadow {
            label.layer.shadowOffset = CGSize(width: 1, height: 1)
            label.layer.shadowRadius = 1
            label.layer.shadowOpacity = 0.5
            label.layer.shadowColor = UIColor.black.cgColor
        }
    }

    fileprivate func removeBadgeLabel(_ label: BadgeLabel, appearance: BadgeAppearance) {
        if appearance.animate {
            UIView.animate(withDuration: appearance.duration, animations: {
                label.alpha = 0.0
                label.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }, completion: { (_) in
                label.removeFromSuperview()
            })
        } else {
            label.removeFromSuperview()
        }

    }

    fileprivate func animateBadgeAppearance(label: BadgeLabel, appearance: BadgeAppearance, doesBadgeExist: Bool, oldWidth: CGFloat?) {
        if !doesBadgeExist {
            // should it animate?
            if appearance.animate {
                label.transform = CGAffineTransform(scaleX: 0, y: 0)

                UIView.animate(withDuration: appearance.duration,
                               delay: 0,
                               usingSpringWithDamping: 0.5,
                               initialSpringVelocity: 0.5,
                               options: [],
                               animations: {
                                label.transform = .identity
                               },
                               completion: nil)
            }
        } else {
            if appearance.animate, let oldWidth = oldWidth {
                let currentWidth = label.frame.width
                label.frame.size.width = oldWidth
                UIView.animate(withDuration: appearance.duration) {
                    label.frame.size.width = currentWidth
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

    public func badge(text badgeText: String?, appearance: BadgeAppearance = .default) {
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
@objc class BadgeLabel: UILabel {

    override func removeFromSuperview() {
        super.removeFromSuperview()
        NSLayoutConstraint.deactivate(constraints)
    }
}

/// BadgeAppearance - This struct is used to design the badge.
public struct BadgeAppearance {

    public static var `default`: BadgeAppearance {
        return .init()
    }

    public var font: UIFont = .systemFont(ofSize: 12)
    public var textAlignment: NSTextAlignment = .center
    public var borderColor: UIColor = .clear
    public var borderWidth: CGFloat = 0.0
    public var allowShadow: Bool = false
    public var backgroundColor: UIColor = .red
    public var textColor: UIColor = .white
    public var animate: Bool = true
    public var duration: TimeInterval = 0.2
    public var distanceFromCenterY: CGFloat?
    public var distanceFromCenterX: CGFloat?
    public var radius: CGFloat?


    public init(font: UIFont = .systemFont(ofSize: 12),
                textAlignment: NSTextAlignment = .center,
                borderColor: UIColor = .clear,
                borderWidth: CGFloat = 0.0,
                allowShadow: Bool = false,
                backgroundColor: UIColor = .red,
                textColor: UIColor = .white,
                animate: Bool = true,
                duration: TimeInterval = 0.2,
                distanceFromCenterY: CGFloat? = nil,
                distanceFromCenterX: CGFloat? = nil,
                radius: CGFloat? = nil) {
        self.font = font
        self.textAlignment = textAlignment
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.allowShadow = allowShadow
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.animate = animate
        self.duration = duration
        self.distanceFromCenterY = distanceFromCenterY
        self.distanceFromCenterX = distanceFromCenterX
        self.radius = radius
    }
}
