The Riggings
=================

[ ![Codeship Status for wearehanno/riggings](https://codeship.io/projects/62ff1160-09e4-0132-177d-4af473c3e2ac/status?branch=master)](https://codeship.io/projects/31635)

Prototype fast, and deploy to a server for feedback and staging! This is the internal repo we use at [Hanno](http://hanno.co/) for rapid prototyping.


####What's included?

1. Middleman prototyping setup using [Zurb Foundation](http://foundation.zurb.com/) Sass, via [Bower](http://bower.io/). Bootstrap is available as an alternative - just scroll down this README to the PICKFRAMEWORK section)
3. [CodeShip](http://codeship.io/), for CI testing and automated deployment to our server
4. [Slack](http://slack.com) configuration sensible preferences, to keep the team updated.


##Quickstart

Install these things on your machine:

1. Install a [Ruby](http://www.ruby-lang.org/en/downloads/) version via RVM. We're using 2.2.1
2. Install [Bundler](http://bundler.io/)
3. Install [Bower](http://bower.io/) (`$ npm install -g bower`)

Then get the app-specific stuff set up:

1. `$ bower install` to install web package dependencies for the project
2. `$ bundle` to install Ruby gems (including Middleman)
3. `$ npm install` to install the node packages we need for Gulp
4. `$ npm install -g gulp` to get Gulp working
5. `$ gulp` to build the CSS for the app
6. `$ middleman s` to start the Middleman server

If you want to edit Sass, and have Middleman reload it for you, use `$ gulp watch` at step #5.

You'll then be able to see the site at [localhost:4567](http://localhost:4567). For more help follow [Middleman's project template instructions](http://middlemanapp.com/getting-started/welcome/).


##Picking a Framework (Bootstrap vs Foundation)

Yup, we feel that way sometimes, too. Riggings is set up for Foundation but can easily be switched to Bootstrap.

Search in this repo for `PICKFRAMEWORK`. There are sections in 6 files, which you'll need to modify. Even if you want to stick with Foundation, you should still follow these steps just to remove the Bootstrap references so that you have a clean repository:

1. In `bower.json`, choose the framework you need and copy it into the dependencies
2. In `config.rb` adjust the `config.add_import_path`
3. In `all.js` change the framework JS file being included
4. In `app.js` remove the Foundation initialisation at `$(document).foundation();`
5. In `app.css.scss`, there are a few lines at the top to import the Sass components
6. In `layout.erb` there's a call to Modernizr, which we don't need for Bootstrap

Then, when you're done, we need to change the framework via Bower:

	# Remove the unused bower components
	$ bower prune
	# Install the new ones
	$ bower install

And finally, don't forget to update the `source/layouts/layout.erb` file and other pages like `source/index.html.erb` to remove the Foundation-specific HTML grid and components.


##Deploying it to a server

###Configure the CodeShip setup and test commands

It's possible to upload files via FTP to a server, but this is a complete pain. Instead, we'll use CodeShip to streamline the process and make sure nobody breaks the build accidentally.

First, visit [codeship.io](https://codeship.io), login, and click to create a new project. Select the GitHub option and choose the repo from GitHub.

####Setup commands

We use a few commands to load dependencies and get the Codeship build server configured:

	rvm use 2.2.1
	bundle install
	npm install -g bower
	npm install -g gulp
	npm install
	bower install

####Test commands

Here's where we build the app. 

	# Compile the sass and assets
	gulp dist
	# Compile the static site with Middleman
	bundle exec middleman build

_Really, these commands could be in the setup, but we'll keep them here for now, until we have better tests :smile:_

Next, save your project, and push to the GitHub repo to trigger a build. If it succeeds, it'll show up as a green build on CodeShip. If it fails, you've got an issue, because the tests should all pass on the clean scaffolding repo.


###Build a server

It's perfectly possible to [deploy to S3](http://blog.codeship.io/2014/02/04/continuous-deployment-static-pages-amazon-s3.html) with CodeShip, but for now, let's deploy to a regular LAMP server, because we might need to password-protect the files while we're working on the project.

We usually use a simple Lamp stack hosted on [DigitalOcean](https://www.digitalocean.com/), so we can have easily provisionable servers to build on.

You'll need to:

* Create a server
* Add the CodeShip deploy key as an authorized key on that server
* Note down a valid username, and the server IP

Hanno team members can follow our [internal setup instructions](https://docs.google.com/a/wearehanno.com/document/d/12cRX8vjLjyqlzAuStE_fdsonuAB53dqP-aKrZo_UQW0/edit?usp=sharing) for our DigitalOcean box setup.


###Configure CodeShip to deploy to that server

####Set up the script command for staging

We’ll do a basic copy of the compiled middleman build directory (`/tmp`) from the `~clone` directory which CodeShip creates on their server when they run tests and setup tasks. All we need to define is the server access details (username, server IP, and the path to deploy to on the server).

Next, click to go to **Next Steps** in CodeShip.

1. Click the option at the top for setup of **Continuous Deployment**
2. Go back to CodeShip and select **+ Add a branch to deploy**
3. Enter **develop** as the branch name
4. Select **$script** as the deployment method

Here’s an example to deploy to Hanno staging:

	# Copy the tmp/ directory with the built files over to the staging server
	scp -rpC ~/clone/tmp/ username@serverip:/var/www/hanno.co/subdomains/staging/

	# Now rewrite the folder names to replace the existing public_html with our tmp directory, and clean up
	ssh username@serverip 'mv /var/www/hanno.co/subdomains/staging/public_html /var/www/hanno.co/subdomains/staging/old_public_html'
	ssh username@serverip 'mv /var/www/hanno.co/subdomains/staging/tmp /var/www/hanno.co/subdomains/staging/public_html'
	ssh username@serverip 'rm -rf /var/www/hanno.co/subdomains/staging/old_public_html'


####Later on, you can set up the Production deployment too

Here's an example $script for deploying to a DigitalOcean box containing a client site:

    scp -rpC ~/clone/tmp/ root@111.111.111.111:/var/www/xxxx.com

This would be added to the master branch settings on CodeShip, so that when you save, CodeShip will run the command on your next master branch push.


##Optionally, configure notifications and connectors

Keep clients and team members updated at every step of the process. We use Slack massively, and pipe lots of notifications into a project room where our team and clients can discuss things.

### Add Slack connections

Configure the following inside Slack > Configure Integrations:

* GitHub > Slack (if desired)
* CodeShip > Slack


##Using this repository as a Middleman template

If you're building lots of new projects with this repo, it'll be easiest if you turn it into a Middleman template. Here's how to do that:

Clone this repo into `~/.middleman` (you'll have to create this directory if it's not already there). You can then use it with the `--template` flag on `middleman init`.

`$ git clone git://github.com/wearehanno/riggings.git ~/.middleman/riggings`

Then create a new project using zurb-foundation template.

1. `$ middleman init my_new_project --template=riggings`
2. `$ cd my_new_project`
3. `$ rm -rf -- .git` to delete the template's git repo, which is copied into this repo too, and you won't want it