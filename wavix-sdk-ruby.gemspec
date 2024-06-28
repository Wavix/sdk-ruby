# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name          = 'wavix-sdk-ruby'
  s.version       = '1.0.0'
  s.authors       = ['Wavix']
  s.email         = ['support@wavix.com']
  s.summary       = 'Wavix Public API SDK for Ruby'
  s.homepage      = 'https://wavix.com'
  s.license       = 'MIT'
  s.metadata = {
    'homepage_uri' => 'http://wavix.com/',
    'changelog_uri' => 'https://ci.unitedline.net/wavix/wavix-sdk-ruby/-/tree/master/CHANGELOG.md',
    'source_code_uri' => 'https://ci.unitedline.net/wavix/wavix-sdk-ruby/-/tree/master',
    'bug_tracker_uri' => 'https://ci.unitedline.net/wavix/wavix-sdk-ruby/-/issues'
  }
  s.files = %w[LICENSE README.md wavix-sdk-ruby.gemspec] + Dir['lib/**/*.rb']
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']
  s.bindir = 'bin'

  s.extra_rdoc_files  = ['README.md', 'LICENSE']
  s.rdoc_options      = ['--charset=UTF-8']

  s.required_ruby_version = '>= 2.5.5'

  s.add_runtime_dependency 'faraday', '>= 0.17.6'
  s.add_dependency 'faraday-multipart', '~> 1.0.4'
  s.add_dependency 'json-schema', '~> 2.8.1'
  s.add_development_dependency 'rspec', '~> 3.13.0'
  s.add_development_dependency 'rubocop', '~> 1.60.2'

  s.description = <<-DESC.gsub(/^    /, '')
    Ruby integrations for Wavix Public API
  DESC
end
