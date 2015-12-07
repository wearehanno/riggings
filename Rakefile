desc "Run the preview server at http://localhost:4567"
task :start do
  puts "## Pruning Bower"
  system("bower prune")
  puts "## Installing Bower components"
  system("bower install")
  puts "## Running gem bundle"
  system("bundle")
  puts "## Starting MM server"
  system("middleman server")
end

desc "Run the build tests"
task :test do
  puts "## Installing Bower components"
  system("bower install")
  puts "## Building website"
  status = system("middleman build --clean")
  puts status ? "OK" : "FAILED"
end

desc "Build the website from source"
task :build do
  puts "## Building website"
  status = system("middleman build --clean")
  puts status ? "OK" : "FAILED"
end

# Here's an example of how you string multiple tasks together
# desc "Build and deploy website"
# task :gen_deploy => [:build, :deploy] do
# end
