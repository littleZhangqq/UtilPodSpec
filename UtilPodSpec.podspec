Pod::Spec.new do |s|
  s.name         = 'UtilPodSpec'
  s.version      = '1.0.0'
  s.summary      = '常用的工具集合，相册工具，定位工具，部分类别，扩展等'
  s.description  = <<-DESC
                   On the basis of project util, more convenient, more concise.
                   DESC
  s.homepage     = 'https://github.com/littleZhangqq/UtilPodSpec.git'
  s.license      = 'MIT'
  s.authors      = { "zhangqq" => "[892750407@qq.com]" }
  s.ios.deployment_target = '10.0'
  s.requires_arc = true
  s.source       = { :git => "https://github.com/littleZhangqq/UtilPodSpec.git", :tag => "1.0.0"}
  s.source_files = '/Util/*.{h,m}'
  s.ios.frameworks = 'MobileCoreServices', 'UIKit', 'CoreTelephony'
  s.frameworks = 'Foundation', 'SystemConfiguration'
end

