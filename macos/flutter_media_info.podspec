#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint mediainfo.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_media_info'
  s.version          = '0.0.2'
  s.summary          = 'Library for use LibMediaInfo in flutter with support for macos, windows, linux.'
  s.description      = <<-DESC
  Library for use LibMediaInfo in flutter with support for macos, windows, linux.
                       DESC
  s.homepage         = 'https://github.com/pcpl2/flutterMediainfo'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Patryk "pcpl2" Ławicki' => 'pubdev@pcpl2.ovh' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
  }
  s.swift_version = '5.0'
  s.resources = ['libs/libmediainfo.dylib']
  s.xcconfig = { 'LD_RUNPATH_SEARCH_PATHS' => '@loader_path/../Frameworks/flutter_media_info.framework/Resources' }
end
