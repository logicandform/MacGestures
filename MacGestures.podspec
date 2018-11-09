Pod::Spec.new do |s|
  s.name                    = 'MacGestures'
  s.version                 = '1.0.0'
  s.summary                 = 'Touch gesture system for macOS and Appkit. Requires touch input stream.'
  s.description             = 'MacGestures is a touch gesture library for macOS and AppKit. Views can be registered for touch gestures much like UIKit on iOS. HID complient touch screen hardware is required to be hooked up to a touch broadcasting device. See HID_PiGesture.'
  s.homepage                = 'https://github.com/logicandform/MacGestures'
  s.license                 = { :type => 'MIT', :file => 'LICENSE' }
  s.author                  = { 'Logic&Form' => 'info@logicandform.com' }
  s.source                  = { :git => 'https://github.com/logicandform/MacGestures.git', :tag => s.version.to_s }
  s.platform                = :osx
  s.osx.deployment_target   = '10.14'
  s.source_files            = 'Sources/**/*.swift'
  s.swift_version           = '4.2'
end
