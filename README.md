# Artist Manager

## Features

### A universal platform for any type of artist to showcase their work

+ Add/Edit your work
+ Add multiple images all at once with jquery-file-upload
+ Group work into Series
+ Embed YouTube videos
+ Adjust Site Settings including uploading a logo, changing the site name, setting a splash page, updating account information, etc.
+ Use a Google Calendar to show upcoming events
+ Accept payments with Paypal 
+ Choose default views for your series and work (slideshow, image scroller, plain), and even series/work specific settings if needed.
+ Flexible CSS Theme framework for customization (see below for more info)

## Logging In

Since logging into the site is not a feature intended for the public, there is no link to the login page.  You can access it by...

+ From the 'Home' page, press `Ctrl + l`
+ Go to `http://[site_name]/login`

## Demo

A demo is available at [am.wearemanalive.com](http://an.wearemanalive.com)

You can login from [am.wearemanalive.com/login](http://am.wearemanalive.com/login) with the username and password `username` and `password` as an administrator with full control over settings and modifying work.

The demo site will be reset back to the defaults every Saturday at midnight, so dont be afraid of breaking anything :) 

## Requirements

+ RVM:          `http://beginrescueend.com`
+ Bundler Gem:  `gem install bundler`

## Install

```
git clone git://github.com/brewster1134/artist_manager.git [APP NAME]
cd [APP NAME]
bundle install
```

## Setup

Modify `db/seeds.rb` with the information for you initial account

```
rake db:migrate
rake db:seed
```

For development (or any non-production environment), you can instead run `rake dev_db:seed` to populate the site with some sample data.

**THIS WILL DROP YOUR DATABASE AND DELETE ANY FILES YOU UPLOADED THROUGH THE SITE!**

## Deployment

### WEBrick (OSX)

For development environment, from app directory...

+ `rails s`

### Passenger

From app directory...

+ `mkdir tmp`
+ `touch tmp/restart.txt`

### FastCGI (Not actually tested)

Refer to: https://github.com/dre3k/rails3_fcgi for setup.

For DreamHost: http://wiki.dreamhost.com/Ruby_on_Rails

## Web Server

### Apache

should be ready to go!

### Nginx

in `config/environmnets/production.rb` change:

`config.action_dispatch.x_sendfile_header = "X-Sendfile"`

to

`config.action_dispatch.x_sendfile_header = "X-Accel-Redirect"`

## Customizing

### Settings

To edit the site settings, you must first login with the credentials provided in the seeds.rb file.

### Assets

All assets are located in `app/assets`

Controller & Controller/View specific CSS and JAVASCRIPT files are automatically loaded from the `controllers` subdirectory if the files exists.

For example...

When visiting the work#index view, the following files will be looked for...

+ `app/assets/stylesheets/controllers/work.css.sass`
+ `app/assets/stylesheets/controllers/work.index.css.sass`
+ `app/assets/javascripts/controllers/work.js.coffee`
+ `app/assets/javascripts/controllers/work.index.js.coffee`

It will also find these assets with an additional `.erb` extension, if ruby parsing is neccessary.

3rd party add-ons have generic asset wrappers for easily swapping them out.

For example...

+ By default the site uses nivoslider for the slideshow
+ Any view using the slider (eg `work#show`), loads the file `work.show.js.coffee` & `work.show.css.sass` 
+ `work.show.js.coffee` requires `slideshow.js.coffee` and `work.show.css.sass` requires `slideshow.css.sass` 
+ `slideshow.js.coffee` & `slideshow.css.sass` contain all the nivoslider requirements and code

This allows you to replace the contents of `slideshow.js.coffee` && `slideshow.css.sass` with a slideshow of your choosing...

However you **WILL** have to update any views that use the slideshow to have the proper markup for your new slideshow.  And any view-specific assets might need updated to pass any JS parameters to your new slideshow.

### CSS 

All styles are located in `app/assets/stylesheets`

+ `settings`      color and site default styles
+ `theme_layout`  layout CSS
+ `theme_views`   common view CSS
+ `forms`         form related CSS
+ `tables`        table related CSS
+ `mixins`        sass mixins for common site styles