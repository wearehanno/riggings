The Riggings
=================

![https://travis-ci.org/wearehanno/riggings](https://travis-ci.org/wearehanno/riggings.svg?branch=master)

Riggings is the internal framework we use at [Hanno](http://hanno.co/) for rapid prototyping apps and websites. The goal is to have a clickable prototype online within 5 minutes of cloning this repository :rocket:

It includes [Middleman](https://middlemanapp.com/), [Zurb Foundation](http://foundation.zurb.com/), a bunch of helpful components, and is set up to deploy to [Netlify](https://www.netlify.com/). Riggings is  an _opinionated_ framework and is designed to suit the way we work and deploy sites.

Riggings is a prototyping framework, yes, but that doesn't mean it's not production-ready, especially when hosted on Netlify, which takes care of stuff like asset minification and concatenation.

To see what the default (very basic) page looks like, check out this repository deployed to Netlify at [hanno-riggings.netlify.com](http://riggings.hanno.co/).

## Quickstart

### Prerequisites:

1. [Ruby](http://www.ruby-lang.org/en/downloads/) via [rbenv](https://github.com/sstephenson/rbenv). Check our current version inside [`.ruby-version`](./.ruby-version)
2. [Bundler](http://bundler.io/): `gem install bundler`
3. [Bower](http://bower.io/): `npm install -g bower`

### Initialise the app

1. Run `rake start`. If you have any issues with this, visit the [`Rakefile`](./Rakefile) in this repo and try running each of the commands individually. For example, take `system("middleman server")` and type `middleman server` into the console.
2. Then go to [http://localhost:4567/](http://localhost:4567/)

## Deploying it to Netlify

We used to deploy staging sites to a Linux server, but it was too much hassle. We've settled on [Netlify](https://www.netlify.com/) because it makes our life far easier and takes care of the grunt work for us.

1. Go to [Netlify](https://www.netlify.com/) and connect your GitHub account. Select the repository you'd like to deploy.
2. In the **settings** modal
  - choose which branch you'd like to deploy
  - leave the **Directory** set to `/build`.
3. In the **Build Command** field, enter `rake build`.

Feel free to set up a password to protect the build and give it a custom URL.

_Netlify automatically looks for `.gemfiles` and the `bower.json`, and runs them, so there's very little that we actually need to set up._


## Optionally, configure notifications and connectors

Keep clients and team members updated at every step of the process. We live inside Slack, and pipe lots of notifications into a project room where our team and clients can discuss things. Check out the [Netlify Webhooks documentation](https://www.netlify.com/docs/webhooks) for details (takes 2 minutes to configure).


# Additional configuration and notes

## Running Tests

This repository is already running through [Travis](https://travis-ci.org) to make sure the `middleman build` completes properly. You should do this for your own project too, before deploying.

You can easily add tests by modifying the `:test` command inside the [`Rakefile`](./Rakefile).


## Switching the frontend framework to Bootstrap

Yup, sometimes a different framework is a better bet. Riggings is set up for Foundation but can easily be switched to Bootstrap.

Search in this repo for `PICKFRAMEWORK`. There are sections in several files, which you'll need to modify. Even if you want to stick with Foundation, you should still follow these steps just to remove the Bootstrap references so that you have a clean repository:

1. In `bower.json`, choose the framework you need and copy it into the dependencies
2. In `source/assets/javascripts/all.js` change the framework JS file being included
3. In `source/assets/javascripts/_app.js.coffee` remove the Foundation initialisation at `$(document).foundation();`
4. In `source/assets/stylesheets/all.scss`, you'll need to switch the vendor/foundation include for the vendor/bootstrap one instead

Then, when you're done, run `rake start` as usual.

And finally, don't forget to update the `source/layouts/layout.erb` file and other pages like `source/index.html.erb` to remove the Foundation-specific HTML grid and components.


## Using this repository as a Middleman template

If you're building lots of new projects with this repo, it'll be easiest if you turn it into a Middleman template. Here's how to do that:

Clone this repo into `~/.middleman` (you'll have to create this directory if it's not already there). You can then use it with the `--template` flag on `middleman init`.

`$ git clone git://github.com/wearehanno/riggings.git ~/.middleman/riggings`

Then create a new project using zurb-foundation template.

1. `$ middleman init my_new_project --template=riggings`
2. `$ cd my_new_project`
3. `$ rm -rf -- .git` to delete the template's git repo, which is copied into this repo too, and you won't want it

##Asset minification

Middleman can do this by itself (and it does it very well, in fact), but we prefer to allow Netlify to handle this for us, so that we're not doing double-minification, and also to keep things simpler at our end. This is why we're not using Middleman's inbuilt asset hashing on URLs, too.
