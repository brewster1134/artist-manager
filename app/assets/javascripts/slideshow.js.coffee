#// http://nivo.dev7studios.com/
//= require jquery.nivo.slider.min

$ ->
  $.fn.slideshow = (options) ->
    $(@).nivoSlider(options)