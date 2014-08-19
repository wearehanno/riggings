heroku-foundation
=================

Prototype fast, and deploy to Heroku for feedback and staging! This is the internal repo we use at [Hanno](http://hanno.co/) for rapid prototyping.


## What's included?

1. Middleman prototyping setup using [Zurb Foundation](http://foundation.zurb.com/) Sass, via [Bower](http://bower.io/)
2. [Heroku](http://heroku.com) configuration, via [Puma](http://puma.io/), for fast staging server setup. Includes simple http auth, to keep things private.
3. [CodeShip](http://codeship.io/), for CI testing and automated deployment to Heroku
4. [Slack](http://slack.com) configuration, from Wercker, to post notifications to your project room on Slack when a build is attempted.
5. [BugHerd](http://www.bugherd.com/) for feedback collection, connected


## Step 1: install the app locally

Software installation, before we can dig into the repo:

1. Install a [Ruby](http://www.ruby-lang.org/en/downloads/) version via RVM
2. Install [Bundler](http://bundler.io/)
3. Install [Bower](http://bower.io/) (`$ npm install -g bower`)

Clone this repo into `~/.middleman` (you'll have to create this directory if it's not already there). You can then use it with the `--template` flag on `middleman init`.

`$ git clone git://github.com/wearehanno/heroku-foundation.git ~/.middleman/heroku-foundation`

Then create a new project using zurb-foundation template.

1. `$ middleman init my_new_project --template=heroku-foundation`
2. `$ cd my_new_project`
3. `$ rm -rf -- .git` to delete the template's git repo, which is copied into this repo too, and you won't want it
4. `$ bower install` to install web package dependencies for the project
5. `$ bundle` to install Ruby gems (including Middleman)
6. `$ middleman s` to start the Middleman server

You'll then be able to see the site at [localhost:4567](http://localhost:4567). For more help follow [Middleman's project template instructions](http://middlemanapp.com/getting-started/welcome/).



## Step 2: Set up the app on Heroku

The first person in the team to build the app needs to set it up on Heroku. If you're not the first, and have been added as a collaborator but need to alter the Heroku settings, please watch out for step 3, below:

1. Make sure you have the [Heroku Toolbelt](https://toolbelt.heroku.com/) installed.
2. `$ cd` to this repository
3. **Either** `$ heroku apps:create my_new_project` if you're creating the project for the first time, or `git@heroku.com:my_new_project.git` if you're joining an existing app.
4. Update the `Rack::Auth::Basic` configuration in `config.ru` to set a different username and password for the auth.

If you're not planning to use Wercker, at this point, you could just deploy the app manually by pushing to Heroku using `$ git push heroku master`

Your app will be visible at `http://my_new_project.herokuapp.com`


## Step 3: Configure CodeShip

You can just manually deploy using `git push` to Heroku, but we're not doing this, and instead, we'll use CodeShip to streamline the process and make sure nobody breaks the build accidentally.

**TODO: Add setup instructions for CodeShip**


## Step 4: Configure notifications and connectors

Keep clients and team members updated at every step of the process. We use Slack massively, and pipe lots of notifications into a project room where our team and clients can discuss things.

### Add Slack connections

Configure the following inside Slack > Configure Integrations:

* Heroku > Slack
* GitHub > Slack (if desired)
* CodeShip > Slack

### GitHub to BugHerd

Go to: `https://github.com/yourusername/myreponame/settings/hooks`

* Copy and paste the key from your project settins, adding it to the Project Key field in your GitHub project under **Admin > Service Hooks > BugHerd**.
* Also, tick the Active box
* And then click **Update Settings**.

# Credits

Foundation and Bower setup was originally based on the [middleman-zurb-foundation](https://github.com/axyz/middleman-zurb-foundation) template.
