// Watch out for the equals sign in the "//=" at the beginning of lines.
// This needs to be present for the scripts that you actually want to include

// For scripts inside this /assets/javascripts directory, use _yourscriptname.js
// with an underscore if the script needs to be concatenated into this file.
// Skip the underscore if you want the script to exist by itself (maybe it's
// specific to a single page, for example).

//= require jquery/dist/jquery

// ----- FOUNDATION
// TODO: PICKFRAMEWORK: Remove the next few lines if you don't use Foundation
//= require what-input/what-input.js
// NOTE: For final build, you should modify this to only include foundation.core.js
// and the plugins you're actually using
//= require foundation-sites/dist/foundation.js

// ----- BOOTSTRAP
// TODO: PICKFRAMEWORK: Enable this if you want to use Boostrap
// require bootstrap-sass/assets/javascripts/bootstrap.js

// ----- GLOBAL APP JS
// Use this file for anything that needs to be accessible on every page of the site
//= require _app
