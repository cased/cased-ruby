# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cased/version'

Gem::Specification.new do |spec|
  spec.name          = 'cased-ruby'
  spec.version       = Cased::VERSION
  spec.authors       = ['Garrett Bjerkhoel']
  spec.email         = ['garrett@cased.com']

  spec.summary       = 'Ruby library for Cased'
  spec.description   = 'Ruby library for Cased'
  spec.homepage      = 'https://github.com/cased/cased-ruby'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/cased/cased-ruby'
  spec.metadata['changelog_uri'] = 'https://github.com/cased/cased-ruby/releases'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.7.0'

  spec.add_dependency 'activesupport', '>= 6.1', '< 8'
  spec.add_dependency 'dotpath', '~> 0.1.0'
  spec.add_dependency 'faraday', '~> 2.0'
  spec.add_dependency 'json', '~> 2.5.1'
  spec.add_dependency 'jwt', '~> 2.7.1'
  spec.add_dependency 'net-http-persistent', '~> 4.0.1'
  spec.add_dependency 'subprocess', '~> 1.5.5'
  spec.add_dependency 'tty-prompt', '~> 0.23.1'
  spec.add_development_dependency 'bundler', '~> 2.4.15'
  spec.add_development_dependency 'byebug', '~> 11.1.3'
  spec.add_development_dependency 'minitest', '~> 5.14.4'
  spec.add_development_dependency 'mocha', '~> 1.13.0'
  spec.add_development_dependency 'rack', '~> 2.2.3'
  spec.add_development_dependency 'rake', '~> 13.0.6'
  spec.add_development_dependency 'rubocop', '~> 1.20.0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.11.5'
  spec.add_development_dependency 'sidekiq', '6.0.7'
  spec.add_development_dependency 'webmock', '~> 3.14.0'
  spec.add_development_dependency 'yard', '~> 0.9.26'
end
