heroku-foundation
=================

## Warning! This repo is not quite ready for primetime - there are some issues when it's deployed to Heroku, and these need to be fixed.

Prototype fast, and deploy to Heroku for feedback and staging! This is the internal repo we use at [Hanno](http://wearehanno.com/) for rapid prototyping.


## What's included?

1. Middleman prototyping setup using [Zurb Foundation](http://foundation.zurb.com/) Sass, via [Bower](http://bower.io/)
2. [Heroku](http://heroku.com) configuration, via [Puma](http://puma.io/), for fast staging server setup. Includes simple http auth, to keep things private
3. [Wercker](http://wercker.com/), for CI testing and automated deployment to Heroku
4. [HipChat](http://hipchat.con) configuration, from Wercker, to post notifications to your project room on HipChat when a build is attempted.
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
3. `$ bower install` to install web package dependencies for the project
4. `$ bundle` to install Ruby gems (including Middleman)
4. `$ middleman s` to start the Middleman server 

You'll then be able to see the site at [localhost:4567](http://localhost:4567). For more help follow [Middleman's project template instructions](http://middlemanapp.com/getting-started/welcome/).



## Step 2: Set up the app on Heroku

The first person in the team to build the app, needs to set it up on Heroku. If you're not the first, and have been added as a collaborator, please watch out for step 3, below:

1. Make sure you have the [Heroku Toolbelt](https://toolbelt.heroku.com/) installed.
2. `$ cd` to this repository
3. **Either** `$ heroku apps:create my_new_project` if you're creating the project for the first time, or `git@heroku.com:my_new_project.git` if you're joining an existing app.
4. Update the `Rack::Auth::Basic` configuration in `config.ru` to set a different username and password for the auth.

If you're not planning to use Wercker, at this point, you could just deploy the app manually by pushing to Heroku using `$ git push heroku master`

Your app will be visible at `http://my_new_project.herokuapp.com`


## Step 3: Configure Wercker

You can just manually deploy using `git push` to Heroku, but we're using Wercker to streamline the process and make sure nobody breaks the build accidentally.

**TODO: Add setup instructions for Wercker**


## Step 4: Configure notifications and connectors

Keep clients and team members updated at every step of the process. We use HipChat massively, and pipe lots of notifications into a project room where our team and clients can discuss things.


### Heroku to HipChat

First, configure deployment notifications for Heroku deploys, with the HipChat API token, and the ID of the room you wish to post to:

    $ heroku addons:add deployhooks:hipchat \
    --auth_token=YOUR_TOKEN_HERE \
   	 --room="YOUR_ROOM_HERE"


### GitHub to HipChat

Go to: `https://github.com/yourusername/myreponame/settings/hooks`

* **Auth Token**: Set to YOUR_TOKEN_HERE
* **Room**: YOUR_ROOM_HERE
* **Active**: Tick this


### GitHub to BugHerd

Go to: `https://github.com/yourusername/myreponame/settings/hooks`

* Copy and paste the key from your project settins, adding it to the Project Key field in your GitHub project under **Admin > Service Hooks > BugHerd**.
* Also, tick the Active box
* And then click **Update Settings**.


### Wercker to HipChat

- Add a new pipeline variable called HIPCHAT_TOKEN
- Protect it, for security
- Set the value as `YOUR_TOKEN_HERE`
- Ensure `Wercker.yml` in the repo has the room ID set, so Wercker knows where to post notifications


# Credits

Foundation and Bower setup was originally based on the [middleman-zurb-foundation](https://github.com/axyz/middleman-zurb-foundation) template.
