Pod::Spec.new do |s|
    s.name         = 'YZCycleScrollView'
    s.version      = '1.0.0'
    s.summary      = 'An easy cyclic rotation chart.'
    s.homepage     = 'https://github.com/micyo202/YZCycleScrollView'
    s.license      = 'MIT'
    s.authors      = {'Yanzheng' => 'micyo202@163.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/micyo202/YZCycleScrollView.git', :tag => s.version}
    s.source_files = 'YZCycleScrollView/**/*.{h,m}'
    s.requires_arc = true
end