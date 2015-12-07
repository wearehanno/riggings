The Riggings
=================

Prototype fast, and deploy to a server for feedback and staging! This is the internal repo we use at [Hanno](http://hanno.co/) for rapid prototyping using [Middleman](https://middlemanapp.com/), [Zurb Foundation](http://foundation.zurb.com/) and hosted on [Netlify](https://www.netlify.com/).

## Quickstart

### Prerequisites:

1. [Ruby](http://www.ruby-lang.org/en/downloads/) via [rbenv](https://github.com/sstephenson/rbenv). Check our current version inside [`.ruby-version`](./.ruby-version)
2. [Bundler](http://bundler.io/): `gem install bundler`
3. [Bower](http://bower.io/): `npm install -g bower`

### Initialise the app

1. `rake start`
2. Then go to [http://localhost:4567/](http://localhost:4567/)

_If you have any issues with the `rake start`, visit the `Rakefile` in this repo and try running each of the commands individually. For example, take `system("bower prune")` and type `bower prune` into the console._

## Deploying it to Netlify

We used to deploy this site to a regular Linux server, but it was too much hassle. Purpose built static site hosting services like [Netlify](https://www.netlify.com/) are a much better option.

1. Go to Netlify and connect your GitHub account, then select the repository you'd like to deploy
2. In the settings modal, choose which branch you'd like to deploy and leave the **Directory** set to `/build`.
3. In the **Build Command** field, enter `npm run build`.

Feel free to set up a password to protect the build and give it a custom URL.

_Netlify automatically looks for `package.json` files, `.gemfiles` and `bower.json`, so there's very little that we actually need to set up.  This build command will run the `build` task configured in the [`package.json`](./package.json)._


## Optionally, configure notifications and connectors

Keep clients and team members updated at every step of the process. We use Slack massively, and pipe lots of notifications into a project room where our team and clients can discuss things. Check out the [Netlify Webhooks documentation](https://www.netlify.com/docs/webhooks) for details.


## Running Tests

If you want to run tests before deploying to Netlify, you can use a CI server like [Travis](https://travis-ci.org). If you want to do ths, you'll need to run commands in this sort of sequence:

	# Prepare the test server
	rvm use 2.2.1
	bundle install
	npm install -g bower
	bower install

	# Run the build to see if it works. Insert your tests here too
	middleman build

# Extra Stuff

## Switching the frontend framework to Bootstrap

Yup, we feel that way sometimes, too. Riggings is set up for Foundation but can easily be switched to Bootstrap.

Search in this repo for `PICKFRAMEWORK`. There are sections in several files, which you'll need to modify. Even if you want to stick with Foundation, you should still follow these steps just to remove the Bootstrap references so that you have a clean repository:

1. In `bower.json`, choose the framework you need and copy it into the dependencies
2. In `config.rb` include the `config.add_import_path` for Bootstrap, if you want it
3. In `source/assets/javascripts/all.js` change the framework JS file being included
4. In `source/assets/javascripts/_app.js.coffee` remove the Foundation initialisation at `$(document).foundation();`
5. In `source/assets/stylesheets/all.scss`, you'll need to switch the vendor/foundation include for the vendor/bootstrap one instead

Then, when you're done, we need to change the framework via Bower:

	# Remove the unused bower components
	$ bower prune
	# Install the new ones
	$ bower install

And finally, don't forget to update the `source/layouts/layout.erb` file and other pages like `source/index.html.erb` to remove the Foundation-specific HTML grid and components.


## Using this repository as a Middleman template

If you're building lots of new projects with this repo, it'll be easiest if you turn it into a Middleman template. Here's how to do that:

Clone this repo into `~/.middleman` (you'll have to create this directory if it's not already there). You can then use it with the `--template` flag on `middleman init`.

`$ git clone git://github.com/wearehanno/riggings.git ~/.middleman/riggings`

Then create a new project using zurb-foundation template.

1. `$ middleman init my_new_project --template=riggings`
2. `$ cd my_new_project`
3. `$ rm -rf -- .git` to delete the template's git repo, which is copied into this repo too, and you won't want it
