require 'rspec/core/rake_task'

namespace :test do

  desc 'Runs unit tests only'
  task :unit do
    RSpec::Core::RakeTask.new(:unit) do |t|
      t.pattern = 'spec/unit/**/*_spec.rb'
    end
    Rake::Task['unit'].invoke
  end

end
