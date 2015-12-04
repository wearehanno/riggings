# If you have OpenSSL installed, we recommend updating
# the following line to use "https"
source 'http://rubygems.org'

ruby "2.2.1"

gem "middleman", "3.4.0"
gem "middleman-livereload", "~> 3.4.3"

# Use the SassC wrapper for faster Sass compilation
gem 'middleman3-sassc', '~> 0.0.1'

# For faster file watcher updates on Windows:
gem "wdm", "~> 0.1.0", :platforms => [:mswin, :mingw]

# Cross-templating language block fix for Ruby 1.8
platforms :mri_18 do
  gem "ruby18_source_location"
end
