Pod::Spec.new do |s|

s.name             = "VTGojek"
s.version          = "1.0.1"
s.summary          = "The widget for gojek credit card payment"
s.homepage         = "https://veritrans.co.id/"
s.license          = 'Code is MIT, then custom font licenses.'
s.author           = { "veritrans" => "dev@veritrans.co.id" }
s.source           = { :git => "https://github.com/veritrans/Iossdk-gojek-bin.git", :tag => s.version }
s.platform     = :ios, '7.0'
s.requires_arc = true

s.source_files = 'headers/**/*.{h,m}'
s.public_header_files = 'headers/*.h'
s.framework    = 'UIKit', 'Foundation'
s.ios.vendored_library = 'libiossdk-gojek.a'
s.ios.resource = 'iossdk-gojek.bundle'

end
