Pod::Spec.new do |spec|
  spec.name             = 'PoqHaneke'
  spec.version          = '1.1.0'
  spec.license          = 'Apache'
  spec.homepage         = 'https://github.com/Haneke/HanekeSwift'
  spec.authors          = { 'Hermes Pique' => 'https://twitter.com/hpique' }
  spec.summary          = 'A lightweight generic cache for iOS written in Swift with extra love for images.'
  spec.source           = { :git => 'https://github.com/poqcommerce/HanekeSwift.git', :tag => 'v1.1.0' }

  spec.swift_version = '4.2'
  spec.ios.deployment_target = '8.0'
  spec.tvos.deployment_target = '9.1'

  spec.module_name         = 'Haneke'
  spec.source_files        = 'Haneke/*.swift'
end