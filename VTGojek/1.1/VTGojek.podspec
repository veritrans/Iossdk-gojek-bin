Pod::Spec.new do |s|

s.name             = "VTGojek"
s.version          = "1.1"
s.summary          = "The widget for gojek credit card payment"
s.homepage         = "https://veritrans.co.id/"
s.license          = 'MIT'
s.author           = { "veritrans" => "dev@veritrans.co.id" }
s.source           = { :git => "https://github.com/veritrans/Iossdk-gojek-bin.git", :tag => s.version }
s.platform     = :ios, '7.0'
s.requires_arc = false

s.source_files = 'iossdk-gojek.framework/Versions/A/Headers/*.h'
s.preserve_path = 'iossdk-gojek.framework'
s.ios.resource = 'iossdk-gojek.framework/Versions/A/Resources/iossdk-gojek.bundle'
s.frameworks    = 'UIKit', 'Foundation'

end
