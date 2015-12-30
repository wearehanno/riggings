###
# Compass
###

# Change Compass configuration
compass_config do |config|
  # Set this to the root of your project when deployed:
  config.http_path = "/"

  config.css_dir = "assets/stylesheets"
  config.sass_dir = "assets/stylesheets"
  config.images_dir = "assets/images"
  config.fonts_dir = "assets/fonts"
  config.javascripts_dir = "assets/javascripts"

  # Require any additional compass plugins here.
end

activate :directory_indexes
activate :sassc # SassC compilation for styles

# Add bower's directory to sprockets asset path
after_configuration do
  @bower_config = JSON.parse(IO.read("#{root}/.bowerrc"))
  sprockets.append_path File.join "#{root}", @bower_config["directory"]
end

set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :fonts_dir,  "assets/fonts"
set :images_dir, 'assets/images'


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
# Environment and build settings
###

# Development settings
configure :development do
  activate :livereload
  config[:file_watcher_ignore] += [
    /bower_components\//,
    /node_modules\//,
    /images\//
    ]
end

# Build-specific configuration
set :build_dir, "build"

configure :build do
  # Auto-prefix the CSS when we build it, via middleman-autoprefixer gem
  # Options are here: https://github.com/middleman/middleman-autoprefixer
  activate :autoprefixer do |config|
    config.browsers = ['last 2 versions', 'Explorer >= 9']
  end

  # Build scaled Favicons using the middleman-favicon-maker gem
  # Options are here: https://github.com/follmann/middleman-favicon-maker
  activate :favicon_maker, :icons => {
    "_favicon_template.png" => [
      # Same as apple-touch-icon-57x57.png, for retina iPad with iOS7.
      { icon: "apple-touch-icon-152x152-precomposed.png" },
      # Same as apple-touch-icon-57x57.png, for retina iPad with iOS6 or prior.
      { icon: "apple-touch-icon-144x144-precomposed.png" },
      # Same as apple-touch-icon-57x57.png, for retina iPhone with iOS7.
      { icon: "apple-touch-icon-120x120-precomposed.png" },
      # Same as apple-touch-icon-57x57.png, for retina iPhone with iOS6 or prior.
      { icon: "apple-touch-icon-114x114-precomposed.png" },
      # Same as apple-touch-icon-57x57.png, for non-retina iPad with iOS7.
      { icon: "apple-touch-icon-76x76-precomposed.png" },
      # Same as apple-touch-icon-57x57.png, for non-retina iPad with iOS6 or prior.
      { icon: "apple-touch-icon-72x72-precomposed.png" },
      # Same as apple-touch-icon-57x57.png, for non-retina iPhone with iOS7.
      { icon: "apple-touch-icon-60x60-precomposed.png" },
      # iPhone and iPad users can turn web pages into icons on their home screen. Such link appears as a regular iOS native application. When this happens, the device looks for a specific picture. The 57x57 resolution is convenient for non-retina iPhone with iOS6 or prior. Learn more in Apple docs.
      { icon: "apple-touch-icon-57x57-precomposed.png" },
      # Same as apple-touch-icon.png, expect that is already have rounded corners (but neither drop shadow nor gloss effect).
      { icon: "apple-touch-icon-precomposed.png", size: "57x57" },
      # Same as apple-touch-icon-57x57.png, for "default" requests, as some devices may look for this specific file. This picture may save some 404 errors in your HTTP logs. See Apple docs
      { icon: "apple-touch-icon.png", size: "57x57" },
      # For Android Chrome M31+.
      { icon: "favicon-196x196.png" },
      # For Opera Speed Dial (up to Opera 12; this icon is deprecated starting from Opera 15), although the optimal icon is not square but rather 256x160. If Opera is a major platform for you, you should create this icon yourself.
      { icon: "favicon-160x160.png" },
      # For Google TV.
      { icon: "favicon-96x96.png" },
      # For Safari on Mac OS.
      { icon: "favicon-32x32.png" },
      # The classic favicon, displayed in the tabs.
      { icon: "favicon-16x16.png" },
      # The classic favicon, displayed in the tabs.
      { icon: "favicon.png", size: "16x16" },
      # Used by IE, and also by some other browsers if we are not careful.
      { icon: "favicon.ico", size: "64x64,32x32,24x24,16x16" },
      # For Windows 8 / IE11.
      { icon: "mstile-70x70.png", size: "70x70" },                      
      { icon: "mstile-144x144.png", size: "144x144" },
      { icon: "mstile-150x150.png", size: "150x150" },
      { icon: "mstile-310x310.png", size: "310x310" },
    ]
    # You can also use multiple favicon base images if you want to be super fancy and use a smaller file for
    # the set of small-size favicons
    # "_favicon_template_lores.png" => [
    #   { icon: "favicon.png", size: "16x16" },
    #   { icon: "favicon.ico", size: "64x64,32x32,24x24,16x16" }
    # ]
  }

  # We need this for Netlify, but the after_build stuff may be deprecated when upgrading to Middleman v4
  after_build do |builder|
    # Netlify requires a _redirects file for its redirects, but Middleman ignores files which
    # start with an underscore! So we have to hack it a little.
    src = File.join(config[:source],"_redirects")
    dst = File.join(config[:build_dir],"_redirects")
    builder.source_paths << File.dirname(__FILE__)
    builder.copy_file(src,dst)

    #
    src = File.join(config[:build_dir],"404/index.html")
    dst = File.join(config[:build_dir],"404.html")
    builder.source_paths << File.dirname(__FILE__)
    builder.copy_file(src,dst)
  end

  # FIXME: zurb-foundation currently includes this file in their bower_component
  # but the build task chokes on it: https://github.com/zurb/foundation-sites/issues/7419
  ignore '/bower_components/foundation-sites/foundation-sites.*'
  ignore '/bower_components/**/*.md'
end
