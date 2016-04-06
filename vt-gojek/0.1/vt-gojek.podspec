Pod::Spec.new do |s|
s.name             = "vt-gojek"
s.version          = "0.1"
s.summary          = "The widget for gojek credit card payment"
s.homepage         = "https://github.com/veritrans/Iossdk-gojek-bin"
s.license          = 'Code is MIT, then custom font licenses.'
s.author           = { "Nanang" => "nanang@onebitmedia.com" }
s.source           = { :git => "https://github.com/veritrans/Iossdk-gojek-bin.git", :tag => s.version }

s.platform     = :ios, '7.0'
s.requires_arc = true

#s.vendored_frameworks = 'iossdk-gojek.framework'

s.public_header_files = 'include/iossdk-gojek/*.h'
s.vendored_libraries = 'libiossdk-gojek.a'
s.resource = 'iossdk-gojek.bundle'

end