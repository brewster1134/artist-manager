#// http://fancybox.net/
//= require jquery.fancybox.min

$ ->
  $.fn.lightbox = (options) ->
    $(@).fancybox(options)