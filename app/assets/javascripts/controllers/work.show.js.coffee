//= require slideshow
//= require image_scroller
//= require lightbox

$ ->
  $('.slideshow').nivoSlider()
  $('.image_scroller').thumbnailScroller
    scrollerType: "clickButtons"
    $("a.lightbox").fancybox
      padding: 1,
      cyclic: true,
      overlayColor: '#000000',
      titlePosition: 'inside',
      showCloseButton: false
