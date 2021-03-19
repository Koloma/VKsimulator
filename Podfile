# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'VKsimulator' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  # ignore all warnings from all pods
  #inhibit_all_warnings!
  # Pods for VKsimulator

#  pod 'Alamofire', '~> 5.4.1'
#  pod 'SwiftyJSON', '~> 5.0'
  pod 'RealmSwift', '~> 10.7.2'
  pod 'Firebase/Core', '~> 7.8.1'
  pod 'Firebase/Auth', '~> 7.8.1'
  pod 'Firebase/Database', '~> 7.8.1'
  pod 'Firebase/Firestore', '~> 7.8.1'
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
  end
  
end
