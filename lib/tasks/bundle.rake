namespace :bundle do
  desc 'Execute bundle install'
  task :install do
    system('bundle install')
  end

end
