Pod::Spec.new do |s|

s.name             = "VTGojek"
s.version          = "1.4"
s.summary          = "The widget for gojek credit card payment"
s.homepage         = "https://veritrans.co.id/"
s.license          = 'MIT'
s.author           = { "veritrans" => "dev@veritrans.co.id" }
s.source           = { :git => "https://github.com/veritrans/Iossdk-gojek-bin.git", :tag => s.version }
s.platform     = :ios, '7.0'
s.requires_arc = true

s.source_files = 'headers/*'
s.vendored_libraries = 'libiossdk-gojek.a'
s.resource = 'iossdk-gojek.bundle'
s.frameworks    = 'UIKit', 'Foundation'

end
