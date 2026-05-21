#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint mobile_device_identifier.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'mobile_device_identifier'
  s.version          = '0.0.4'
  s.summary          = 'A Flutter plugin that returns a stable per-install device identifier on iOS and Android.'
  s.description      = <<-DESC
A Flutter plugin that returns a stable per-install device identifier on iOS and Android.
                       DESC
  s.homepage         = 'https://github.com/alfanthariq/mobile_device_identifier'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Nafi Alfanthariq' => 'mnalfanthariq@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'mobile_device_identifier/Sources/mobile_device_identifier/**/*.swift'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
