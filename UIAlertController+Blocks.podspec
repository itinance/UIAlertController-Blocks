Pod::Spec.new do |s|
  s.name         = "UIAlertController+Blocks"
  s.version      = "0.91"
  s.summary      = "Convenience methods for UIAlertController"
  s.homepage     = "https://github.com/itinance/UIAlertController-Blocks"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = "Ryan Maxwell, Hagen Hübel"
  s.source       = { :git => "https://github.com/itinance/UIAlertController-Blocks", :tag => '0.91' }
  s.source_files  = 'UIAlertController+Blocks.{h,m}'
  s.requires_arc = true
  s.platform = 'ios', '8.0' 
end
