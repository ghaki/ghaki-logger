Gem::Specification.new do |s|

  s.name        = 'ghaki-logger'
  s.version     = IO.read(File.expand_path('VERSION')).chomp
  s.summary     = 'Logging with style'
  s.description = 'Ghaki Logger is a collection of extensions for the core Logger object.'

  s.author   = 'Gerald Kalafut'
  s.email    = 'gerald@kalafut.org'
  s.homepage = 'http://ghaki.com/'

  s.platform          = Gem::Platform::RUBY
  s.rubyforge_project = s.name
  s.required_rubygems_version = '>= 1.3.6'

  s.add_dependency 'ghaki-app',  '>= 1.1.3'
  s.add_dependency 'ghaki-core', '>= 2011.11.05.1'

  s.add_development_dependency 'rspec', '>= 2.4.0'
  s.add_development_dependency 'mocha', '>= 0.9.12'
  s.add_development_dependency 'rdoc', '>= 3.9.4'

  s.has_rdoc = true
  s.extra_rdoc_files = ['README']

  s.files = Dir['{lib,bin}/**/*'] + %w{ README LICENSE VERSION }
  s.test_files = Dir['spec/**/*_spec.rb','*spec/**/*_helper.rb']
  s.require_path = 'lib'
end
