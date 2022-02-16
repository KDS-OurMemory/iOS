# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'
use_frameworks!

workspace 'OurMemory'
project 'OurMemoryTask.project'
project 'OurMemory.project'

def shared_pods
     ####firebase####
     pod 'FirebaseMessaging'

     ####snsLogin####

     #### Kakao####
     pod 'KakaoSDKUser'
     pod 'KakaoSDKAuth'
end

target 'OurMemoryTask' do
     project "OurMemoryTask.project"
     shared_pods
end

target 'OurMemory' do
     project "OurMemory.project"
     shared_pods
end