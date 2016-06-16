
Pod::Spec.new do |s|

  s.name         = "SZPresentController"

  s.version      = "0.0.6"

  s.summary      = "modal present view"

  s.homepage     = "https://github.com/chenshengzhi/SZPresentController"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "陈圣治" => "csz2136@163.com" }

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/chenshengzhi/SZPresentController.git", :tag => s.version.to_s }

  s.source_files = "SZPresentController/*.{h,m}"

  s.requires_arc = true

end
