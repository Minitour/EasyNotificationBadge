
<img src="Screenshots/heading.gif"  height="100" />

[![CocoaPods](https://img.shields.io/cocoapods/v/EasyNotificationBadge.svg)]()
[![CocoaPods](https://img.shields.io/cocoapods/l/EasyNotificationBadge.svg)]()
[![CocoaPods](https://img.shields.io/cocoapods/p/EasyNotificationBadge.svg)]()

## Installation

### CocoaPods

```bash
pod 'EasyNotificationBadge'
```

### Swift Package Manager

You can use [The Swift Package Manager](https://swift.org/package-manager) to install `EasyNotificationBadge` by adding the proper description to your `Package.swift` file:

```swift
// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    dependencies: [
        .package(url: "https://github.com/Minitour/EasyNotificationBadge.git", from: "1.2.4"),
    ]
)
```
Then run `swift build` whenever you're ready.

Or simply drag and drop ```NSBadge.swift``` to your project.

## Usage

To add a badge with default settings use this (This also applies to updating an existing badge):
```swift
view.badge(text: "5")
```

To remove the badge:

```swift
view.badge(text: nil)
```

## Advanced Usage

```swift
var badgeAppearance = BadgeAppearance()
badgeAppearance.backgroundColor = UIColor.blue //default is red
badgeAppearance.textColor = UIColor.white // default is white
badgeAppearance.textAlignment = .center //default is center
badgeAppearance.textSize = 15 //default is 12
badgeAppearance.distanceFromCenterX = 15 //default is nil
badgeAppearance.distanceFromCenterY = -10 //default is nil
badgeAppearance.allowShadow = true
badgeAppearance.borderColor = .blue
badgeAppearance.borderWidth = 1
view.badge(text: "Your text", appearance: badgeAppearance)
```

### Important
When calling `.badge` make sure that the view has already been loaded and has a superview. Setting a badge on a view that hasn't fully loaded can lead to unexpected results.
