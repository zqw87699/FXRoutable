Pod::Spec.new do |s|
  s.name         = "FXRoutable"
  s.version      = "1.0.4"
  s.summary      = "路由框架"

  s.homepage     = "https://github.com/zqw87699/FXRoutable"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = {"zhangdazong" => "929013100@qq.com"}

  s.source       = { :git => "https://github.com/zqw87699/FXRoutable.git", :tag => "#{s.version}"}

  s.platform     = :ios, "7.0"

  s.frameworks = "Foundation", "UIKit"

  s.module_name = 'FXRoutable' 

  s.requires_arc = true

s.subspec 'Core' do |score|
    score.source_files = 'Classes/Core/*'
    score.public_header_files = 'Classes/Core/*.h'

    score.dependency 'FXCommon/Core'
    score.dependency 'FXCommon/Utiles'
    score.dependency 'FXRoutable/API'

end

s.subspec 'API' do |sapi|
    sapi.source_files = 'Classes/API/*'
    sapi.public_header_files = 'Classes/API/*.h'
end

  s.dependency "FXLog"

end
