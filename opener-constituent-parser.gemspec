require File.expand_path('../lib/opener/constituent_parser/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'opener-constituent-parser'
  gem.version     = Opener::ConstituentParser::VERSION
  gem.authors     = ['development@olery.com']
  gem.summary     = 'Constituent parser including a webservice.'
  gem.description = gem.summary
  gem.has_rdoc    = 'yard'
  gem.license     = 'Apache 2.0'

  gem.required_ruby_version = '>= 1.9.2'

  gem.files = Dir.glob([
    'lib/**/*',
    '*.gemspec',
    'README.md',
    'LICENSE.txt',
    'exec/**/*',
    'config.ru'
  ]).select { |file| File.file?(file) }

  gem.executables = Dir.glob('bin/*').map { |file| File.basename(file) }

  gem.add_dependency 'opener-webservice'
  gem.add_dependency 'sinatra', '~>1.4.2'
  gem.add_dependency 'opener-constituent-parser-base', ['~> 1.0', '>= 1.0.6']
  gem.add_dependency 'opener-constituent-parser-nl', '~> 1.0'
  gem.add_dependency 'opener-constituent-parser-de', '~> 1.1'
  gem.add_dependency 'puma'
  gem.add_dependency 'nokogiri'
  gem.add_dependency 'httpclient'
  gem.add_dependency 'opener-daemons'
  gem.add_dependency 'opener-core', "~> 1.0"

  gem.add_development_dependency 'rake'
end
