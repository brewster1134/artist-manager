//= require jquery
//= require jquery-ui
//= require jquery_ujs
# require_tree .

$ ->

  #// menu
  main_cats = $('ul#menu>li')
  sub_cats = $('ul#menu>li>ul')
  main_cats.mouseenter ->
    sub_cats.not( $(@).children('ul') ).fadeOut()
    $(@).children('ul').fadeIn()
  sub_cats.mouseleave ->
    $(@).fadeOut() 
