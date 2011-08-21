//= require slideshow
//= require image_scroller

$ ->
  $('.slideshow').nivoSlider()
  $('.image_scroller').thumbnailScroller
    scrollerType: "clickButtons"
