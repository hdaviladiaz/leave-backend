scope group: :specs

group 'specs', halt_on_fail: true do
  guard :bundler do
    watch('Gemfile')
  end

  guard :rspec, all_on_start: true, cmd: 'bundle exec rspec' do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb')  { 'spec/lib' }
  end

  guard :rubocop, all_on_start: false, cmd: 'rubocop --format fuubar -F -D' do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$})
  end

  guard "rubycritic", all_on_start: true do
    watch(%r{^app/(.+)\.rb$})
    watch(%r{^lib/(.+)\.rb$})
  end
end
