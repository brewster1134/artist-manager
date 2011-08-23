//= require slideshow
//= require image_scroller
//= require lightbox

$ ->
  $('.slideshow').nivoSlider()
  $('.image_scroller').thumbnailScroller
    scrollerType: "clickButtons"
