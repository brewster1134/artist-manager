# Artist Manager
## A universal platform for any type of artist to showcase their work

### Features

+ Add/Edit your work
+ Add multiple images all at once with jquery-file-upload
+ Group work into Series
+ Embed YouTube videos
+ Site Settings to modify logo, background, colors, site name, splash page, account information, and more...
+ Use a Google Calendar to show upcoming events
+ Accept payments with Paypal 
+ Choose default views for your series and work (slideshow, image scroller, plain), and even series/work specific settings if needed.
+ Flexible CSS Theme framework for advanced customization (see below for more info)
+ Mobile Site included

### Logging In

Since logging into the site is not a feature intended for the public, there is no link to the login page.  You can access it by...

+ From the 'Home' page, press `Ctrl + l`
+ Go to `http://[site_name]/login`

### Demo

A demo is available at [am.wearemanalive.com](http://am.wearemanalive.com)

You can login from [am.wearemanalive.com/login](http://am.wearemanalive.com/login) with the username and password `username` and `password` as an administrator with full control over settings and modifying work.

The demo site will be reset back to the defaults every Saturday at midnight, so dont be afraid of breaking anything :) 

### Requirements

+ Git:          `http://git-scm.com`
+ RVM:          `http://beginrescueend.com`
+ Bundler Gem:  `gem install bundler`

### Install

```
git clone git://github.com/brewster1134/artist_manager.git [APP NAME]
cd [APP NAME]
git checkout heroku
bundle install
```

### Setup

Modify `db/seeds.rb` with the information for you initial account

```
rake db:migrate
rake db:seed
```

#### Setup Environment Keys

Since images cannot be uploaded and stored with Heroku, cloud storage is required.  It is currently setup to use Amazon S3, but other cloud services can be used.  You just need to update `config/initializers/carrierwave.rb` with the correct configuration.  See https://github.com/jnicklas/carrierwave/wiki/How-to:-Migrate-to-the-new-Fog-storage-provider for more details.

To set environment variables on heroku, use the following command:

```
heroku config:add FOG_DIRECTORY=bucketname AWS_ACCESS_KEY_ID=xxx AWS_SECRET_ACCESS_KEY=yyy
```

To find this information, visit: https://aws-portal.amazon.com/gp/aws/developer/account/index.html?action=access-key and https://console.aws.amazon.com/s3/home?

### Development

For any non-production environment, you can run `rake dev_db:seed` to populate the site with some sample data.
**THIS WILL DROP YOUR DATABASE AND DELETE ANY FILES YOU UPLOADED THROUGH THE SITE!**

If image sizes are changed from the 'Edit Settings' page, the images will be automatically recreated.
However, if changes were NOT made form the 'Edit Settings' page, or something went wrong with image resizing, you can manually recreate them with `rake recreate_images`

For Mobile testing, you can pass a parameter in the url to control viewing the mobile site.

+ `?m=0` will force the NON-mobile layout temporarily 
+ `?m=1` will force the mobile layout temporarily
+ `?m=2` will force the mobile permanently

### Production

The defaults for production are setup for Heroku using PostgreSQL.  If you need to change this, update the Gemfile to reflect that.

### Deployment

#### WEBrick (OSX)

For development environment, from app directory...

+ `rails s`

#### Passenger

From app directory...

+ `mkdir tmp`
+ `touch tmp/restart.txt`

#### FastCGI
##### not personally tested

Refer to: https://github.com/dre3k/rails3_fcgi for setup.
For DreamHost: http://wiki.dreamhost.com/Ruby_on_Rails

### Web Server

#### Apache

should be ready to go!

#### Nginx

in `config/environments/production.rb` change:

`config.action_dispatch.x_sendfile_header = "X-Sendfile"`

to

`config.action_dispatch.x_sendfile_header = "X-Accel-Redirect"`

### Settings

To edit the site settings, you must first login with the credentials provided in the seeds.rb file.

### Advanced Customizing

#### Assets

All assets are located in `app/assets`

Controller & Controller/View specific CSS and JAVASCRIPT files are automatically loaded from the `controllers` subdirectory if the files exists.

For example...

When visiting the work#index view, the following files will be looked for...

+ `app/assets/stylesheets/controllers/work.css.sass`
+ `app/assets/stylesheets/controllers/work.index.css.sass`
+ `app/assets/javascripts/controllers/work.js.coffee`
+ `app/assets/javascripts/controllers/work.index.js.coffee`

It will also find these assets with an additional `.erb` extension, if ruby parsing is neccessary.

##### 3rd party add-ons have generic asset wrappers for easily swapping them out.

For example...

+ By default the site uses nivoslider for the slideshow
+ Any view using the slider (eg `work#show`), loads the file `work.show.js.coffee` & `work.show.css.sass` 
+ `work.show.js.coffee` requires `slideshow.js.coffee` and `work.show.css.sass` requires `slideshow.css.sass` 
+ `slideshow.js.coffee` & `slideshow.css.sass` contain all the nivoslider requirements and code

This allows you to replace the contents of `slideshow.js.coffee` && `slideshow.css.sass` with a slideshow of your choosing...

However you **WILL** have to update any views that use the slideshow to have the proper markup for your new slideshow.  And any view-specific assets might need updated to pass the proper JS parameters to your new slideshow.

#### CSS 

All styles are located in `app/assets/stylesheets`

+ `settings`      color and site default styles
+ `theme_layout`  layout CSS
+ `theme_views`   common view CSS
+ `forms`         form related CSS
+ `tables`        table related CSS
+ `mixins`        sass mixins for common site styles