# Ember-selenium-build

[demo site](https://foxnewsnetwork.gitlab.io/ember-selenium-build/)
A pre-render tool that builds a few pages of your ember app as a static site

# Example:
If you have a router that looks like:

```javascript
Router.map(function(){
  this.route("posts", {path: "/posts"}, function(){
    this.route("new");
  });
  this.route("post", {path: "/post/:post_id"}, function() {
    this.route("edit");
  });
  this.route("terms-of-service");
});
```
Specify in your `ember-selenium-build.js` file what paths you want built:

```javascript
module.exports = ["/", "terms-of-service", "posts", "posts/new", "post/1", "post/1/edit"];
```
Notice that you're manually putting post ids like the worst of plebs. This is okay for small sites (e.g. your personal blog or portfolio which you promised yourself you'd update every week, but haven't written for since a year ago), but I personally advise you checkout [ember-fastboot](https://github.com/ember-fastboot/ember-cli-fastboot) if you have an actual web app that requires the full utilization of database, search, cache, etc., layers.

As a general rule, if you can get away with just using fixture data for your ember app, this addon will be perfect for you.

## How?

Run the commands
```sh
ember selenium-build:build
```

## Installation

* `git clone` this repository
* `npm install`
* `bower install`

## Running

* `ember server`
* Visit your app at http://localhost:4200.

## Running Tests

* `npm run server-test`

## Building

* `ember build`

For more information on using ember-cli, visit [http://ember-cli.com/](http://ember-cli.com/).
