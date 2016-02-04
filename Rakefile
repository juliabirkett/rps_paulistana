namespace :run do
  desc "Run irb console"
  task :console do
    exec "irb -r irb/completion -r #{File.dirname(__FILE__)}/initialize.rb"
  end
end
