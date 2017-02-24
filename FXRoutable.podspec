Pod::Spec.new do |s|
  s.name         = "FXRoutable"
  s.version      = "1.0.6"
  s.summary      = "路由框架"

  s.homepage     = "https://github.com/zqw87699/FXRoutable"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = {"zhangdazong" => "929013100@qq.com"}

  s.source       = { :git => "https://github.com/zqw87699/FXRoutable.git", :tag => "#{s.version}"}

  s.platform     = :ios, "7.0"

  s.frameworks = "Foundation", "UIKit"

  s.module_name = 'FXRoutable' 

  s.requires_arc = true

  s.source_files = 'Classes/*'
  s.public_header_files = 'Classes/*.h'

  s.dependency "FXLog"
  s.dependency "FXCommon/Core" 
  s.dependency "FXCommon/Utiles"
  s.dependency "FXRoutableAPI"

end
