# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/upload_dsym/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-upload_dsym'
  spec.version       = Fastlane::UploadDsym::VERSION
  spec.author        = 'xiongzenghui'
  spec.email         = 'zxcvb1234001@163.com'

  spec.summary       = 'upload dsym to your specify server'
  spec.homepage      = "https://github.com/xzhhe/fastlane-plugin-upload_dsym"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  # Don't add a dependency to fastlane or fastlane_re
  # since this would cause a circular dependency

  # spec.add_dependency 'your-dependency', '~> 1.0.0'
  spec.add_dependency 'rest-client', '>= 2.1.0', '< 3.0'

  spec.add_development_dependency('pry')
  spec.add_development_dependency('bundler')
  spec.add_development_dependency('rspec')
  spec.add_development_dependency('rspec_junit_formatter')
  spec.add_development_dependency('rake')
  spec.add_development_dependency('rubocop')
  spec.add_development_dependency('rubocop-require_tools')
  spec.add_development_dependency('simplecov')
  spec.add_development_dependency('fastlane')
end
