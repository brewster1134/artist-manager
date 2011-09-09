//= require jquery.min
//= require_tree .

$ = jQuery

$('div').live 'pageshow', (event, ui) ->
  $('select#tag_select').change ->
    window.location = "/work?tag=" + $(@).val()
