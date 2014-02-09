heroku-foundation
=================

A minimal [Middleman](http://middlemanapp.com/) project template with the [SASS](http://sass-lang.com/) version of the [Foundation](http://foundation.zurb.com/) Framework. Set up for rapid prototyping and deployment to Heroku.

Originally based on the [middleman-zurb-foundation](https://github.com/axyz/middleman-zurb-foundation) template.


## Installation

Software installation, before we can dig into the repo:

1. Install a [Ruby](http://www.ruby-lang.org/en/downloads/) version via RVM
2. Install [Bundler](http://bundler.io/)
3. Install [Bower](http://bower.io/) (`$ npm install -g bower`)

Clone this repo into `~/.middleman` (you'll have to create this directory if it's not already there). You can then use it with the `--template` flag on `middleman init`.

`$ git clone git://github.com/wearehanno/heroku-foundation.git ~/.middleman/heroku-foundation`

Then create a new project using zurb-foundation template.

1. `$ middleman init my_new_project --template=heroku-foundation`
2. `$ cd my_new_project`
3. `$ bower install` to install web package dependencies for the project
4. `$ bundle` to install Ruby gems (including Middleman)
4. `$ middleman s` to start the Middleman server 

You'll then be able to see the site at [localhost:4567](http://localhost:4567). For more help follow [Middleman's project template instructions](http://middlemanapp.com/getting-started/welcome/).