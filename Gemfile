source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'pg', '~> 0.18'
gem 'rails', '~> 5.1.1'
gem 'rest-client', '~> 2.0.2'

group :production do
  gem 'puma', '~> 3.7'
end
group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'fuubar'
  gem 'guard-bundler', require: false
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false
  gem "guard-rubycritic"
  gem 'pry'
  gem 'pry-byebug'
  gem 'rspec-rails', '>= 3.5.0'
  gem 'rubocop', require: false
  gem 'rubycritic', require: false
  gem 'webmock'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'active_model_serializers'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
