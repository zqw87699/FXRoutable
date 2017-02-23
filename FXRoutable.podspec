Pod::Spec.new do |s|
  s.name         = "FXRoutable"
  s.version      = "1.0.2"
  s.summary      = "路由框架"

  s.homepage     = "https://github.com/zqw87699/FXRoutable"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = {"zhangdazong" => "929013100@qq.com"}

  s.source       = { :git => "https://github.com/zqw87699/FXRoutable.git", :tag => "#{s.version}"}

  s.platform     = :ios, "7.0"

  s.frameworks = "Foundation", "UIKit"

  s.module_name = 'FXRoutable' 

  s.requires_arc = true

s.subspec 'Core' do |core|
    core.source_files = 'Classes/Core/*'
    core.public_header_files = 'Classes/Core/*.h'

    core.dependency 'FXCommon/Core'
    core.dependency 'FXRoutable/API'

end

s.subspec 'API' do |api|
    api.source_files = 'Classes/API/*'
    api.public_header_files = 'Classes/API/*.h'
end

  s.dependency "FXLog"

end
