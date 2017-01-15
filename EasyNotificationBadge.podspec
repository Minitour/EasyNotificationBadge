Pod::Spec.new do |s|
  s.name         = "EasyNotificationBadge"
  s.version      = "1.0.2"
  s.summary      = "UIView extension that adds a notification badge."
  s.homepage     = "https://github.com/Minitour/EasyNotificationBadge"
  s.license      = "MIT"
  s.author       = { "Antonio Zaitoun" => "tony.z.1711@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Minitour/EasyNotificationBadge.git", :tag => "#{s.version}" }
  s.source_files  = "*.swift"
end
