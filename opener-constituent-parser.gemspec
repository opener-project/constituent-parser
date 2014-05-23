require File.expand_path('../lib/opener/constituent_parser/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'opener-constituent-parser'
  gem.version     = Opener::ConstituentParser::VERSION
  gem.authors     = ['development@olery.com']
  gem.summary     = 'Constituent parser including a webservice.'
  gem.description = gem.summary
  gem.has_rdoc    = 'yard'

  gem.required_ruby_version = '>= 1.9.2'

  gem.files = Dir.glob([
    'lib/**/*.*',
    '*.gemspec',
    'README.md',
    'config.ru'
  ])

  gem.executables = Dir.glob('bin/*').map { |f| File.basename(f) }

  gem.add_dependency 'opener-webservice'
  gem.add_dependency 'opener-constituent-parser-base', '>= 0.1.0'
  gem.add_dependency 'puma'
  gem.add_dependency 'nokogiri'

  gem.add_development_dependency 'opener-build-tools'
  gem.add_development_dependency 'rake'
end
