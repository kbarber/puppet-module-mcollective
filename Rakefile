require 'rubygems'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |t|
  # Keep the search pattern succinct so we don't pick up spec tests in the
  # fixtures area
  t.pattern = 'spec/{classes,defines}/**/*_spec.rb'
end
