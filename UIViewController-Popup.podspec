Pod::Spec.new do |s|
  s.name             = "UIViewController-Popup"
  s.version          = "0.0.2"
  s.summary          = "UIViewController extension for poping up an another ViewController with animation effects"
  s.description      = <<-DESC
                       an extension of UIViewController for poping up an another ViewController with animation effects in swift
                       DESC
  s.homepage         = "https://github.com/litt1e-p/UIViewController-PopUp"
  s.license          = { :type => 'MIT' }
  s.author           = { "litt1e-p" => "litt1e.p4ul@gmail.com" }
  s.source           = { :git => "https://github.com/litt1e-p/UIViewController-PopUp.git", :tag => "#{s.version}" }
  s.platform = :ios, '9.0'
  s.requires_arc = true
  s.source_files = 'UIViewController-PopUp/*'
  s.dependency 'VisualEffectView', '~> 3.0.0'
  s.frameworks = 'Foundation', 'UIKit'
end
