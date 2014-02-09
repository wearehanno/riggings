heroku-foundation
=================

A minimal [Middleman](http://middlemanapp.com/) project template with the [SASS](http://sass-lang.com/) version of the [Foundation](http://foundation.zurb.com/) Framework. Set up for rapid prototyping and deployment to Heroku.

Originally based on the [middleman-zurb-foundation](https://github.com/axyz/middleman-zurb-foundation) template.


## Installation ##

Make sure to have:

1. ruby
2. git
4. bower ($ `npm install -g bower`)


Clone into ~/.middleman (you'll have to create this directory if it's not already there). You can then use it with the `--template` flag on `middleman init`.

1. `$ git clone git://github.com/wearehanno/heroku-foundation.git ~/.middleman/heroku-foundation`

Then create a new project using zurb-foundation template.

1. `$ middleman init my_new_project --template=heroku-foundation`
2. `$ cd my_new_project`
3. `$ bower install`
4. `$ bundle`
4. `$ bundle exec middleman`

Now you can start hacking on `source` directory and watch live changes on [localhost:4567](http://localhost:4567).

For more help follow [Middleman's project template instructions](http://middlemanapp.com/getting-started/welcome/).