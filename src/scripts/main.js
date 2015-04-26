// Require Node modules in the browser thanks to Browserify: http://browserify.org
var bespoke = require('bespoke'),
  //theme = require('bespoke-theme-cube'),
  theme = require('bespoke-theme-voltaire'),
  keys = require('bespoke-keys'),
  touch = require('bespoke-touch'),
  backdrop = require('bespoke-backdrop'),
  scale = require('bespoke-scale'),
  sync = require('bespoke-sync/client'),
  indexfinger = require('bespoke-indexfinger'),
  secondary = require('bespoke-secondary'),
  hash = require('bespoke-hash'),
  progress = require('bespoke-progress');

// Bespoke.js
bespoke.from('article', [
  //cube(),
  theme(),
  keys(),
  touch(),
  backdrop(),
  scale(),
  indexfinger(),
  sync(),
  secondary(),
  hash(),
  progress()
]);

// Prism syntax highlighting
// This is actually loaded from "bower_components" thanks to
// debowerify: https://github.com/eugeneware/debowerify
require('prism');
require('prism/components/prism-coffeescript');
require('prism/plugins/line-numbers/prism-line-numbers');

