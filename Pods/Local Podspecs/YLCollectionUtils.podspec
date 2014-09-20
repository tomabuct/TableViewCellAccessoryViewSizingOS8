Pod::Spec.new do |s|
  s.name         = 'YLCollectionUtils'
  s.version      = '1.6.2'
  s.license      = 'Yelp Extreme Licensing Protocol'
  s.summary      = 'Yelp iOS collection and table view utilities'
  s.homepage     = 'https://github.com/Yelp'
  s.authors      = { 'Yelp iOS Team' => 'iphone@yelp.com' }
  s.source       = { :git => 'git@git.yelpcorp.com:ios/YLCollectionUtils.git', :tag => 'v' + s.version.to_s }
  s.requires_arc = true

  s.platform     = :ios
  s.ios.deployment_target = '6.0'

  s.public_header_files = 'Classes/**/*.h'
  s.source_files = 'Classes/**/*.{h,m}'

  s.dependency 'YLUtils', '~> 1.2'
end
