# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

workspace 'OurMemory'
project 'OurMemory.xcodeproj'
project '../common/snsWrapper/snsWrapper.xcodeproj'

target 'snsWrapper' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
	project '../common/snsWrapper/snsWrapper.xcodeproj'
  # Pods for snsWrapper

	pod 'Alamofire'
	pod 'KakaoSDKCommon'
	pod 'KakaoSDKAuth'
	pod 'KakaoSDKUser'

end

project 'OurMemory.xcodeproj'

target 'OurMemory' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
	project 'OurMemory.xcodeproj'
  # Pods for OurMemory
	pod 'Firebase/Messaging'

  target 'OurMemoryTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'OurMemoryUITests' do
    # Pods for testing
  end

end