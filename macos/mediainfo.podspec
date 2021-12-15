#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint mediainfo.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'mediainfo'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
#    'LIBRARY_SEARCH_PATHS' => '$(PODS_TARGET_SRCROOT)/libs',
  }
  s.swift_version = '5.0'
#  s.vendored_libraries = '$(PODS_TARGET_SRCROOT)/libs/libmediainfo.dylib'
  s.resources = ['libs/libmediainfo.dylib']
end
