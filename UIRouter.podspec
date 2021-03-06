#
# Be sure to run `pod lib lint UIRouter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UIRouter'
  s.version          = '0.2.7'
  s.summary          = 'register url to jump vc'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    register url to jump vc to Decoupling
                DESC

  s.homepage         = 'http://code.ds.gome.com.cn/gitlab/Aeromind-iOS/UIRouter'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '“caoye”' => 'caoye@gomeplus.com' }
  s.source           = { :git => 'git@code.ds.gome.com.cn:Aeromind-iOS/UIRouter.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'UIRouter/Classes/**/*'
  
  # s.resource_bundles = {
  #   'UIRouter' => ['UIRouter/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'ArchLogger'

end
