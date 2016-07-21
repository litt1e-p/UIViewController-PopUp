Pod::Spec.new do |s|
  s.name             = "UIViewController-PopUp"
  s.version          = "0.0.1"
  s.summary          = "UIViewController extension for poping up an another ViewController with animation effects"
  s.description      = <<-DESC
                       an extension of UIViewController for poping up an another ViewController with animation effects in swift
                       DESC
  s.homepage         = "https://github.com/litt1e-p/UIViewController-PopUp"
  s.license          = { :type => 'MIT' }
  s.author           = { "litt1e-p" => "litt1e.p4ul@gmail.com" }
  s.source           = { :git => "https://github.com/litt1e-p/UIViewController-PopUp.git", :tag => "#{s.version}" }
  s.platform = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'UIViewController-PopUp/*'
  s.frameworks = 'Foundation', 'UIKit'
end
