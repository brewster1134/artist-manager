//= require file_upload
//= require markup
//= require jquery.autocomplete
 
$ ->
  $('select#tag_select').change ->
    window.location = work_index_path + "?tag=" + $(@).val()

  # For Sale behavior
  for_sale_checkbox = $('input#work_for_sale')
  for_sale_fieldset = $('fieldset#for_sale') 
  for_sale_fieldset.hide() if !for_sale_checkbox.is(':checked')
  for_sale_checkbox.change ->
    if for_sale_checkbox.is(':checked')
      for_sale_fieldset.slideDown()
    else
      for_sale_fieldset.slideUp()