# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'bamboo-iOS' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for bamboo-iOS
  
  # Utils
  pod 'SnapKit', '~> 5.0.0'
  pod 'Then'
  pod 'GoogleSignIn'
  pod 'KeychainSwift', '~> 19.0'
  pod 'PanModal'
  pod 'Reusable'
  pod 'DropDown'
  pod 'IQKeyboardManagerSwift'

  # Networking
  pod 'Moya/RxSwift'

  #Rx
  pod 'RxSwift'
  pod 'RxCocoa'
   
  #RxFramework
  pod "RxAppState"
  pod 'RxViewController'
  pod 'RxFlow'
  pod 'ReactorKit'
  pod 'RxKeyboard'
  pod 'RxGesture'
  pod 'RxDataSources'
  
  #RxTest
  target 'bamboo-iOSTests' do
    pod 'RxTest'
    pod 'RxNimble'
    end
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
  end
end
