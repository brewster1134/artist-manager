#// http://nivo.dev7studios.com/
//= require jquery.nivo_slider

$ ->
  $.fn.slideshow = (options) ->
    $(@).nivoSlider(options)