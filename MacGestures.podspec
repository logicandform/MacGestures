#
# Be sure to run `pod lib lint MacGestures.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MacGestures'
  s.version          = '0.1.0'
  s.summary          = 'Touch gesture system for macOS and Appkit. Requires touch input stream.'
  s.description      = <<-DESC
MacGestures is a touch gesture library for macOS and AppKit. Views can be registered for touch gestures much like UIKit on iOS. HID complient touch screen hardware is required to be hooked up to a touch broadcasting device. See HID_PiGesture.
                       DESC
  s.homepage         = 'https://github.com/SlantDesign/MacGestures'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 't2davis' => 'davistim@me.com' }
  s.source           = { :git => 'https://github.com/SlantDesign/MacGestures.git', :tag => s.version.to_s }
  s.platform = :osx
  s.osx.deployment_target = "10.14"
  s.source_files = 'Sources/**/*'

end
