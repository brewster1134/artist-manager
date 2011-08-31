# Artist Manager

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

## Customizing

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