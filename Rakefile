############################################################################
require 'rake'
require 'rspec/core/rake_task'
require 'rake/rdoctask'

############################################################################
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rspec_opts = %w[--color -r spec/spec_helper]
  t.verbose = true
end

Rake::RDocTask.new('rdoc') do |t|
  t.rdoc_files.include( 'README', 'lib/**/*./rb')
  t.main = 'README'
  t.title = 'Ghaki Logger API Documention'
end

############################################################################
