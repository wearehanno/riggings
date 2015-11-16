###
# Compass
###

# Change Compass configuration
compass_config do |config|
  # Require any additional compass plugins here.

  # TODO: PICKFRAMEWORK: Choose the one you want, and comment out the other one
  # Foundation
  config.add_import_path "bower_components"
  # Bootstrap
  # config.add_import_path "bower_components/bootstrap-sass-official/assets"

  # Set this to the root of your project when deployed:
  config.http_path = "/"
  config.css_dir = "assets/stylesheets"
  config.sass_dir = "assets/stylesheets"
  config.images_dir = "assets/images"
  config.fonts_dir = "assets/fonts"
  config.javascripts_dir = "assets/javascripts"
end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
helpers do
  def some_helper
    "Helping"
  end
end

# Add bower's directory to sprockets asset path
after_configuration do
  @bower_config = JSON.parse(IO.read("#{root}/.bowerrc"))
  sprockets.append_path File.join "#{root}", @bower_config["directory"]
end

activate :directory_indexes
set :build_dir, "build"

set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'

configure :development do
  activate :livereload
  config[:file_watcher_ignore] += [
    /bower_components\//,
    /node_modules\//,
    /images\//,
    /source-sass\//
    ]
end

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  activate :asset_hash do |config|
    config.ignore = ['assets/stylesheets/app.css']
  end

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end