//= require slideshow
//= require image_scroller

$ ->
  $('.slideshow').slideshow()

window.onload = ->
  $('.image_scroller').imageScroller
    scrollerType: "clickButtons"
