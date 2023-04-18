require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'xrechnung/validator/download'
require 'xrechnung/validator/run'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

namespace :validator do
  desc 'Download official validator and scenarios'
  task :download do
    path = Pathname.new(__dir__).join('validator')
    Xrechnung::Validator::Download.new(path: path).call
  end

  desc 'Run validator'
  task run: :download do
    path = Pathname.new(__dir__).join('validator')
    pattern = Pathname.new(__dir__).join('spec/fixtures/*.xml')
    files = Pathname.glob(pattern).map(&:to_s).join(' ')
    Xrechnung::Validator::Run.new(path: path, files: files).call
  end
end
