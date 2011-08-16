//= require jquery.fileupload
//= require jquery.fileupload-ui
//= require jquery.tmpl.js
//= require jquery.iframe-transport

$ ->
  if $('#fileupload').size()
    $('#fileupload').fileupload
      autoUpload: true,
      destroy: (e, data) ->
        $.blueimpUI.fileupload.prototype.options.destroy.call(this, e, data) if confirm 'Are you sure?'
  
    images = $('div.fileupload-content')
    toggle_buttons = $('button.toggle_files')
    show_button = $('button.toggle_files.show')
    hide_button = $('button.toggle_files.hide')
    show_button.children('span.ui-button-icon-primary').removeClass('ui-icon-circle-arrow-e').addClass('ui-icon-circle-triangle-e')
    hide_button.children('span.ui-button-icon-primary').removeClass('ui-icon-circle-arrow-e').addClass('ui-icon-circle-triangle-s')
  
    toggle_files = (force) ->
      if !images.is(':visible') or force
        images.slideDown()
        show_button.hide()
        hide_button.show()
      else
        images.slideUp()
        show_button.show()
        hide_button.hide()
        
    $('#fileupload').bind 'fileuploadadd', ->
      toggle_files(true)
  
    toggle_buttons.click ->
      toggle_files()
  
    # Load existing files:
    $.getJSON $('#fileupload form').prop('action'), (files) ->
      fu = $('#fileupload').data('fileupload')
      fu._adjustMaxNumberOfFiles -files.length
      fu._renderDownload(files)
        .appendTo($('#fileupload .files'))
        .fadeIn ->
          # Fix for IE7 and lower:
          $(this).show()
    
    # Open download dialogs via iframes to prevent aborting current uploads:
    $('#fileupload .files a:not([target^=_blank])').live 'click', (e) ->
      e.preventDefault()
      $('<iframe style="display:none;"></iframe>')
        .prop('src', this.href)
        .appendTo('body')