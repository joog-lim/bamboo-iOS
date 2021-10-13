# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'bamboo-iOS' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for bamboo-iOS
  
  # Utils
    pod 'SnapKit', '~> 5.0.0'
    pod 'Then'
   
  #Rx
  
  pod 'RxSwift'
  pod 'RxCocoa'
  
  #RxFramework
  
  pod 'RxFlow'
  pod 'ReactorKit'
  
  #Pod for testing
  
target 'bamboo-iOSTests' do
  inherit! :search_paths
  #Pods for testing
  
  pod 'RxNimble', subspecs: ['RxBlocking', 'RxTest']
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
  end
end
