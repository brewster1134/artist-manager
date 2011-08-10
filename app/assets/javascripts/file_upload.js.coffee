//= require jquery.fileupload
//= require jquery.tmpl.js
//= require jquery.iframe-transport
//= require jquery.fileupload-ui

$ ->
  
  # Initialize file upload
  $('#fileupload').fileupload()

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