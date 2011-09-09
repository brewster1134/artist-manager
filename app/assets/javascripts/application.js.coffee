//= require jquery.min
//= require jquery-ui.min
//= require jquery_ujs
//= require jquery.cookie
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

  alert ("You have to keep the footer at the bottom with a link to Man Alive! if you want to avoid seeing this message!") if !$("#footer").length || $("#footer").html().indexOf('wearemanalive.com') == -1 or $("#footer").is(':hidden')
