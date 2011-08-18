//= require jquery.min
//= require jquery-ui.min
//= require jquery_ujs
# require_tree .

$ = jQuery

#// toggle plugin
$.fn.toggle = (id, currentState = "show", showText = "Show", hideText = "Hide") ->
  link = $(@)
  element = $('#' + id)
  return false if !element?
  if element.is(':visible')
    link.html(showText)
    element.slideUp()
  else
    link.html(hideText)
    element.slideDown()

$ ->

  $('.hide').hide()

  #// menu
  main_cats = $('ul#menu>li')
  sub_cats = $('ul#menu>li>ul')
  main_cats.mouseenter ->
    sub_cats.not( $(@).children('ul') ).fadeOut()
    $(@).children('ul').fadeIn()
  sub_cats.mouseleave ->
    $(@).fadeOut() 


