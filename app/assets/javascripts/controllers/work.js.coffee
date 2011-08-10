//= require file_upload
//= require jquery.autocomplete
//= require markup

$ ->
  images = $('div.fileupload-content')
  images.hide()
  toggle_link = $('a#toggle_images')

  toggle_images = (force) ->
    if !images.is(':visible') or force
      toggle_link.html('Hide Images')
      images.slideDown()
    else
      toggle_link.html('Show Images')
      images.slideUp()
      
  toggle_link.click ->
    toggle_images()

  $('#fileupload').bind 'fileuploadadd', ->
    toggle_images(true)

  # For Sale behavior
  for_sale_checkbox = $('input#work_for_sale')
  for_sale_fieldset = $('fieldset#for_sale') 
  for_sale_fieldset.hide() if !for_sale_checkbox.is(':checked')
  for_sale_checkbox.change ->
    if for_sale_checkbox.is(':checked')
      for_sale_fieldset.slideDown()
    else
      for_sale_fieldset.slideUp()