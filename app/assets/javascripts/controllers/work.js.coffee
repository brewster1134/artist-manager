//= require file_upload
//= require markup
//= require jquery.autocomplete
//= require lightbox
 
$ ->
  
  $('button.image_toggle').click ->
    if $('#fileupload .content').is(':visible')
      $(@).find('.ui-icon').removeClass('ui-icon-triangle-1-n').addClass('ui-icon-triangle-1-s')
      $(@).find('.ui-button-text').text('Show Images')
    else
      $(@).find('.ui-icon').removeClass('ui-icon-triangle-1-s').addClass('ui-icon-triangle-1-n')
      $(@).find('.ui-button-text').text('Hide Images')
    $('#fileupload .content').slideToggle()

  $('#fileupload').bind 'fileuploadadd', ->
      $('#fileupload .content').slideDown()

  $("a.lightbox").livequery ->
    $(@).lightbox
      padding: 1,
      cyclic: true,
      overlayColor: '#000000',
      titlePosition: 'inside',
      showCloseButton: false

  $('select#tag_select').change ->
    window.location = work_index_path + "?tag=" + $(@).val()

  for_sale_checkbox = $('input#work_for_sale')
  for_sale_fieldset = $('fieldset#for_sale') 
  for_sale_fieldset.hide() if !for_sale_checkbox.is(':checked')
  for_sale_checkbox.change ->
    if for_sale_checkbox.is(':checked')
      for_sale_fieldset.slideDown()
    else
      for_sale_fieldset.slideUp()