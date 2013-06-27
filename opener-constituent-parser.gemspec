require File.expand_path('../lib/opener/constituent_parser/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'opener-constituent-parser'
  gem.version     = Opener::ConstituentParser::VERSION
  gem.authors     = ['development@olery.com']
  gem.summary     = 'Constituent parser including a webservice.'
  gem.description = gem.summary
  gem.has_rdoc    = 'yard'

  gem.required_ruby_version = '>= 1.9.2'

  gem.files       = `git ls-files`.split("\n").sort
  gem.executables = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files  = gem.files.grep(%r{^(test|spec|features)/})

  gem.add_dependency 'builder', '~> 3.1'
  gem.add_dependency 'sinatra', '~> 1.4'
  gem.add_dependency 'httpclient'
  gem.add_dependency 'opener-constituent-parser-base'

  gem.add_development_dependency 'opener-build-tools'
  gem.add_development_dependency 'rake'
end
