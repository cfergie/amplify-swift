#
#  Be sure to run `pod spec lint AWSS3StoragePlugin.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

# Version definitions
$AMPLIFY_VERSION = '2.25.2'
$AMPLIFY_RELEASE_TAG = "v#{$AMPLIFY_VERSION}"

$AWS_SDK_VERSION = '2.33.7'
$OPTIMISTIC_AWS_SDK_VERSION = "~> #{$AWS_SDK_VERSION}"

Pod::Spec.new do |s|
  s.name         = 'AmplifyPlugins'
  s.version      = $AMPLIFY_VERSION
  s.summary      = 'Amazon Web Services Amplify for iOS.'

  s.description  = 'AWS Amplify for iOS provides a declarative library for application development using cloud services'

  s.homepage     = 'https://github.com/cfergie/amplify-swift'
  s.license      = 'Apache License, Version 2.0'
  s.author       = { 'Amazon Web Services' => 'amazonwebservices' }
  s.source       = { :git => 'https://github.com/cfergie/amplify-swift.git', :tag => $AMPLIFY_RELEASE_TAG }

  s.platform = :ios, '16'
  s.swift_version = '5.0'

  s.dependency 'AWSPluginsCore', $AMPLIFY_VERSION

  # This is technically redundant, but adding it here allows Xcode to find it
  # during initial indexing and prevent build errors after a fresh install
  s.dependency 'AWSCore', $OPTIMISTIC_AWS_SDK_VERSION

  # s.subspec 'AWSAPIPlugin' do |ss|
  #   ss.source_files = 'AmplifyPlugins/API/AWSAPICategoryPlugin/**/*.swift'
  #   ss.dependency 'AppSyncRealTimeClient', "~> 3.0"
  # end

  s.subspec 'AWSCognitoAuthPlugin' do |ss|
    # ss.source_files = 'AmplifyPlugins/Auth/AWSCognitoAuthPlugin/**/*.swift'
    ss.source_files = 'AmplifyPlugins/Auth/Sources/AWSCognitoAuthPlugin/**/*.swift'
    ss.dependency 'AWSMobileClient', $OPTIMISTIC_AWS_SDK_VERSION

    # # This is technically redundant, but adding it here allows Xcode to find it
    # # during initial indexing and prevent build errors after a fresh install
    # ss.dependency 'AWSAuthCore', $OPTIMISTIC_AWS_SDK_VERSION
    # ss.dependency 'AWSCognitoIdentityProvider', $OPTIMISTIC_AWS_SDK_VERSION
    # ss.dependency 'AWSCognitoIdentityProviderASF', $OPTIMISTIC_AWS_SDK_VERSION
  end

  # s.subspec 'AWSDataStorePlugin' do |ss|
  #   ss.source_files = 'AmplifyPlugins/DataStore/AWSDataStoreCategoryPlugin/**/*.swift'
  #   ss.dependency 'SQLite.swift', '0.13.2'
  # end

  # s.subspec 'AWSLocationGeoPlugin' do |ss|
  #   ss.source_files = 'AmplifyPlugins/Geo/AWSLocationGeoPlugin/**/*.swift'
  #   ss.dependency 'AWSLocation', $OPTIMISTIC_AWS_SDK_VERSION
  # end

  # s.subspec 'AWSPinpointAnalyticsPlugin' do |ss|
  #   ss.source_files = 'AmplifyPlugins/Analytics/AWSPinpointAnalyticsPlugin/**/*.swift'
  #   ss.dependency 'AWSPinpoint', $OPTIMISTIC_AWS_SDK_VERSION
  # end

  # s.subspec 'AWSS3StoragePlugin' do |ss|
  #   ss.source_files = 'AmplifyPlugins/Storage/AWSS3StoragePlugin/**/*.swift'
  #   ss.dependency 'AWSS3', $OPTIMISTIC_AWS_SDK_VERSION
  # end

end
